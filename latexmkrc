#!/usr/bin/env perl
@default_files    = ('report.tex');
$pdf_mode         = 3;
#$latex            = 'platex -halt-on-error';
#$latex_silent     = 'platex -halt-on-error -interaction=batchmode';
#$bibtex           = 'pbibtex';
# %O はオプション %S はソースファイル %D は出力ファイル %B は拡張子なしのソースファイル
$latex            = 'uplatex -synctex=1 -halt-on-error -interaction=nonstopmode';
$latex_silent     = 'uplatex -synctex=1 %O %S -halt-on-error -interaction=batchmode';
$bibtex           = 'upbibtex %O %B';
$dvipdf           = 'dvipdfmx %O -o %D %S';
$makeindex        = 'mendex %O -o %D %S';
$max_repeat       = 5;
$pdf_previewer    = 'evince';
