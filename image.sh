# _posts 내에서 ../images 를 access 하고 있는 모든 이미지들의 경로를 절대 경로로 변경
#
sed -i '' 's/\.\.\/images\//\/images\//g' _posts/*.md
