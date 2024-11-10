from flask import Flask, render_template, request
from flask_sqlalchemy import SQLAlchemy
from flask_mail import Mail, Message
import json

with open("config.json", 'r') as f:
    params = json.load(f)["params"]
local_server = True

app = Flask(__name__)

app.config.update(
    MAIL_SERVER='smtp.gmail.com',
    MAIL_PORT=465,
    MAIL_USE_SSL=True,
    MAIL_USERNAME=params['gmail_user'],
    MAIL_PASSWORD=params['app_password']
)
mail = Mail(app)

uri = params['local_uri'] if local_server else params['prod_uri']
app.config["SQLALCHEMY_DATABASE_URI"] = uri
db = SQLAlchemy(app)

class Contacts(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80), unique=False, nullable=False)
    phone_num = db.Column(db.String(12), unique=True, nullable=False)
    msg = db.Column(db.String(120), nullable=False)
    date = db.Column(db.String(12), nullable=True)
    email = db.Column(db.String(20), nullable=False)

    def __init__(self, name, phone_num, msg, date, email):
        self.name = name
        self.phone_num = phone_num
        self.msg = msg
        self.date = date
        self.email = email

class Posts(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(80), unique=False, nullable=False)
    slug = db.Column(db.String(50), unique=True, nullable=False)
    content = db.Column(db.String(120), nullable=False)
    tagline = db.Column(db.String(120), nullable=False)
    date = db.Column(db.String(12), nullable=True)
    img_file = db.Column(db.String(50), nullable=True)


@app.route("/")
def home():
    posts = Posts.query.filter_by().all()[:params['no_of_posts']]
    return render_template("index.html", params=params, posts=posts)

@app.route("/about")
def about():
    return render_template("about.html", params=params)

@app.route("/post/<string:post_slug>", methods=['GET'])
def post_route(post_slug):
    post = Posts.query.filter_by(slug=post_slug).first()
    print(post)
    return render_template("post.html", params=params, post=post)

@app.route("/contact", methods=['GET', 'POST'])
def contact():
    if request.method == "POST":
        name = request.form.get('name')
        email = request.form.get('email')
        phone = request.form.get('phone')
        message = request.form.get('message')
        entry = Contacts(name=name, phone_num=phone, msg=message, date=None, email=email)
        db.session.add(entry)
        db.session.commit()
        # Send email
        msg = Message('New Contact Form Submission', sender=params['gmail_user'], recipients=[params['gmail_user']])
        msg.body = f"Name: {name}\nEmail: {email}\nPhone: {phone}\nMessage: {message}"
        mail.send(msg)
    return render_template("contact.html", params=params)

if __name__ == "__main__":
    app.run(debug=True)