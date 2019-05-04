# Jekyll & Bootstrap 4

使用 `jekyll + bootstrap 4` 搭建静态站点，并且发布到 `github pages` 中。

> 由于 `github pages` 自带的 `jekyll` 出于安全原因采用 `--safe` 选项去执行 `jekyll`，因此导致很多插件和功能无法使用。
> 鉴于此，不使用 `github pages` 自带的 `jekyll` 去编译，而是采用本地使用 `jekyll` 编译好站点，直接传到 `github` 仓库中去。

## Step 0 - Pre-requires

已经安装了 `jekyll`

已经安装了 `node.js`。主要是要使用 `npm`。

## Step 1 - Create Github Repository

在 GitHub 上创建一个仓库

使用 Git 命令 Clone 该仓库到本地 *<local_repo>*

## Step 2 - Installing Bootstrap 4

```bash
$ cd <local_repo>
$ jekyll new . --blank --force
$ npm init --force
$ npm install bootstrap
$ npm install jquery
$ npm install popper.js
```

## Step 3 - Adding Sass load paths

在 <local_repo> 的根目录下的 `_config.yml` 文件中添加如下内容

```yml
sass:
  load_paths:
    - _sass
    - node_modules
```

> 上面这个配置的核心意义在于，`jekyll` 默认仅从 `_sass` 目录下读取 `.scss` 文件，为了引入 `bootstrap` 的样式表，必须告诉 `jekyll` 还需要从 `node_modules` 目录下去加载编译 `.scss` 文件。

## Step 4 - Import Sass file

在 <local_repo> 的根目录下创建 `assets/css/main.scss` 文件，录入如下内容

```scss
---
---

@import "bootstrap/scss/bootstrap"
```

> 注意：上面文件中的头两行 `---` 不能遗漏，否则 `jekyll` 不会编译该文件。

## Step 5 - Add css to layout

在 <local_repo> 的根目录下创建 `_layouts/default.html` 文件，录入如下内容

```html
<link rel="stylesheet" href="{{ '/assets/css/main.css' | prepend: site.baseurl }}">
```

## Step 6 - Add JavaScripts to layout

在 <local_repo> 的根目录下创建 `_layouts/default.html` 文件，录入如下内容

```html
<script src="{{ '/assets/vendor/jquery.min.js' | prepend: site.baseurl }}"></script>
<script src="{{ '/assets/vendor/popper.min.js' | prepend: site.baseurl }}"></script>
<script src="{{ '/assets/vendor/bootstrap.min.js' | prepend: site.baseurl }}"></script>
```

## Step 7 - default.html

增加了 css 和 javascript 引用后的完整的 `_layouts/default.html` 内容如下

```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="{{ '/assets/css/main.css' | prepend: site.baseurl }}">
  </head>

  <body>
    <h1>Hello, world</h1>

    <script src="{{ '/assets/vendor/jquery.min.js' | prepend: site.baseurl }}"></script>
    <script src="{{ '/assets/vendor/popper.min.js' | prepend: site.baseurl }}"></script>
	  <script src="{{ '/assets/vendor/bootstrap.min.js' | prepend: site.baseurl }}"></script>
  </body>
</html>
```

## Step 8 - _config.yml

```yml
sass:
  load_paths:
    - _sass
    - node_modules

destination: ./docs

baseurl: /project_page_site

exclude:
  - node_modules
  - LICENSE
  - Makefile
  - README.md
  - package.json
  - package-lock.json
  - yarn.lock

include:
  - .nojekyll
```

## Step 9 - Add .nojekyll

在 <local_repo> 的根目录下创建 `.nojekyll` 空文件。该文件用于告知 `Github` 无需编译，直接发布站点内容即可。

## Step 10 - .gitignore

```git
node_modules/
.sass-cache/
```

## Step 11 - index.html

在 <local_repo> 的根目录下创建 `index.html` 文件，录入如下内容：

```html
---
layout: default
---
```

## Step 12 - Makefile

在 <local_repo> 的根目录下创建 `Makefile` 文件，录入如下内容：

```makefile
NPM := npm
VENDOR_DIR := assets/vendor/
JEKYLL := jekyll

install:
	$(NPM) install

include-npm-deps:
	mkdir -p $(VENDOR_DIR)
	cp node_modules/jquery/dist/jquery.min.js $(VENDOR_DIR)
	cp node_modules/popper.js/dist/umd/popper.min.js $(VENDOR_DIR)
	cp node_modules/bootstrap/dist/js/bootstrap.min.js $(VENDOR_DIR)

build: install include-npm-deps
	$(JEKYLL) build

serve: install include-npm-deps
	$(JEKYLL) serve
```

> 使用 `make biuld` 和 `make serve` 来替代 `jekyll build` 和 `jekyll serve`

## 参考资料
  - [5 Steps To Add Bootstrap 4 To Jekyll The Right Way](https://simpleit.rocks/ruby/jekyll/tutorials/how-to-add-bootstrap-4-to-jekyll-the-right-way/)
  - [minimalistic example site](https://github.com/marcanuy/jekyll-bootstrap4)