#!/usr/bin/env python

from flask import Flask, render_template_string
import markdown

# app = Flask(__name__)
app = Flask(
    __name__,
    template_folder='.',  # 表示在当前目录 (myproject/A/) 寻找模板文件
    static_folder='',     # 空 表示为当前目录 (myproject/A/) 开通虚拟资源入口
    static_url_path='',
)

@app.route('/')
def home():
    with open('cs_tutor.md', 'r') as markdown_file:
        content = markdown_file.read()
        html_content = markdown.markdown(content)
        return render_template_string('''
            <html>
                <head>
                    <style>
                        img {{
                            max-width: 100%;
                            width: auto;
                            height: auto;
                        }}
                    </style>
                </head>
                <body>
                    {}
                </body>
            </html>
        '''.format(html_content))

if __name__ == '__main__':
    # app.run(debug=True)
    app.run(host='0.0.0.0',debug=True)
