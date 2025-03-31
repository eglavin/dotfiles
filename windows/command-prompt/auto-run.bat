@echo off

DOSKEY l=dir $*
DOSKEY ls=dir /B $*
DOSKEY ll=dir /B /A $*

DOSKEY clear=cls

DOSKEY e.=explorer .
DOSKEY e..=explorer ..

DOSKEY c.=code .
DOSKEY c..=code ..
