from flask import Flask, render_template, request, session, redirect
from flask_sqlalchemy import SQLAlchemy
from flask_mail import Mail, Message
import json, os, math
from werkzeug.utils import secure_filename
from datetime import datetime

with open("config.json", 'r') as f:
    params = json.load(f)["params"]
local_server = True

app = Flask(__name__)
app.secret_key = "anything-here"

app.config['UPLOAD_FOLDER'] = params['upload_location']
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
    
    def __init__(self, title, slug, content, tagline, img_file, date):
        self.title=title
        self.slug=slug
        self.content=content
        self.img_file=img_file
        self.tagline=tagline
        self.date = date

@app.route("/")
def home():
    page = request.args.get("page")
    posts = Posts.query.filter_by().all()
    no_of_posts = int(params['no_of_posts'])

    last = len(posts)//no_of_posts+1
    print(f"{last=}")

    if not str(page).isnumeric():
        page = 1
    page=int(page)
    posts = posts[(page-1)*no_of_posts: (page-1)*no_of_posts+no_of_posts]
    
    if page==1:
        prev = "#"
        next = "/?page="+str(page+1)
    elif page==last:
        prev = "/?page="+str(page-1)
        next = "#"
    else:
        prev = "/?page="+str(page-1)
        next = "/?page="+str(page+1)
        

    return render_template("index.html", params=params, posts=posts, prev=prev, next=next)

@app.route("/dashboard", methods=["GET", "POST"])
def dashboard():
    if 'user' in session and session['user'] == params['admin_user']:
        posts = Posts.query.all()
        return render_template("dashboard.html", params=params, posts = posts)

    if request.method == "POST":
        #redirect to admin
        username = request.form.get('uname')
        userpass = request.form.get('pass')
        if username==params['admin_user'] and userpass == params['admin_password']:
            session['user'] = username
            posts = Posts.query.all()
            return render_template("dashboard.html", params=params, posts = posts)
    
    return render_template("signin.html", params=params)


@app.route("/uploader", methods=['GET', 'POST'])
def uploader():
    if 'user' in session and session['user'] == params['admin_user']:
        if request.method=="POST":
            f=request.files['file1']
            if f.filename:
                filename = secure_filename(f.filename)
                f.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
    return "Upload success!!!"
    

@app.route("/logout")
def logout():
    if 'user' in session:
        session.pop('user')
    return redirect('/dashboard')

@app.route("/about")
def about():
    return render_template("about.html", params=params)

@app.route("/post/<string:post_slug>", methods=['GET'])
def post_route(post_slug):
    post = Posts.query.filter_by(slug=post_slug).first()
    print(post)
    return render_template("post.html", params=params, post=post)

@app.route("/delete/<string:sno>", methods=['GET', 'POST'])
def delete(sno):
    if 'user' in session and session['user'] == params['admin_user']:
        post = Posts.query.filter_by(sno=sno).first()
        db.session.delete(post)
        db.session.commit()
    return redirect('/dashboard')


@app.route("/edit/<string:sno>", methods=['GET', 'POST'])
def edit(sno):
    if 'user' in session and session['user'] == params['admin_user']:
        if request.method=="POST":
            box_title = request.form.get("title")
            tline = request.form.get("tline")
            slug = request.form.get("slug")
            content = request.form.get("content")
            img_file = request.form.get("img_file")
            date = datetime.now()
            
            if sno=='0':
                post = Posts(title=box_title, slug=slug, content=content, img_file=img_file, tagline=tline, date=date)
                db.session.add(post)
                db.session.commit()
            else:
                post = Posts.query.filter_by(sno=sno).first()
                post.title = box_title 
                post.slug = slug 
                post.tagline = tline
                post.content = content
                post.img_file = img_file
                post.date = date
                db.session.commit()
                return redirect("/dashboard")
            
    post = Posts.query.filter_by(sno=sno).first()
    return render_template("edit.html", params=params, post=post)

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