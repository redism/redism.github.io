# redism.github.com

* How to setup writing environment?

```
git clone https://github.com/redism/redism.github.io.git
cd redism.github.io
git checkout develop
sudo gem install jekyll bundler
bundle install
=> bundle update (if failed)
```

* Writing a new post

```
./draft.sh "New blog post title"
typora ./_drafts/-*
```

* Publishing a new post

```
bundle exec jekyll publish _drafts/real-artists-ship.md
# mv ./_drafts/{file} ./_posts/2016-12-06-{file}.md
bundle exec jekyll build
```



