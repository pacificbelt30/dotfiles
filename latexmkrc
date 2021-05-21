#!/usr/bin/env perl
@default_files    = ('report.tex');
$pdf_mode         = 3;
#$latex            = 'platex -halt-on-error';
#$latex_silent     = 'platex -halt-on-error -interaction=batchmode';
#$bibtex           = 'pbibtex';
$latex            = 'uplatex -halt-on-error';
$latex_silent     = 'uplatex -halt-on-error -interaction=batchmode';
$bibtex           = 'upbibtex';
$dvipdf           = 'dvipdfmx %O -o %D %S';
$makeindex        = 'mendex %O -o %D %S';
$max_repeat       = 5
