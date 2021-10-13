cp web/config/$1/index.html web/index.html && flutter build web --release --web-renderer html

source '/Users/matsumarutsuyoshi/google-cloud-sdk/path.bash.inc'
source '/Users/matsumarutsuyoshi/google-cloud-sdk/path.zsh.inc'

gsutil cp -r /Users/matsumarutsuyoshi/AndroidStudioProjects/web_demo/build/web gs://exapmle-web-parameters/

open https://storage.googleapis.com/exapmle-web-parameters/web/index.html?id=123