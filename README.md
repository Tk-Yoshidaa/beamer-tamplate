# beamer-tamplate
Template of beamer slides

## コンパイル 

`slide.tex` を編集し, 以下のコマンドによって`slide.pdf`を作成する.

```
make
```

## 画像の追加

`fig` ディレクトリにおく. `.tex`ファイル内で`\includegraphics{fig/hoge.pdf}`として`hoge.pdf`をインクルードできます.

## 参考文献の追加

`.bib` に追記. 本文中で`\citep`で引用する. 
引用されていない文献が`.bib`にあるとエラーになるので注意してください.

