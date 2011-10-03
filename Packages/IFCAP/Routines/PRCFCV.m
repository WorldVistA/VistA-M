PRCFCV ;WISC@ALTOONA/CTB-CONVERT DATA IN FILE 411 TO FREE TEXT POINTER ;10 Sep 89/3:08 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 S ASK=1
NOASK W !,"I will now convert your IFCAP site parameter file to support the new data structure."
 I $D(ASK) S %A="OK to Continue",%B="",%=1 D ^PRCFYN Q:%'=1
 W !!
 S N=0 F I=1:1 S N=$O(^PRC(411,N)) Q:'N  I $D(^(N,0)) S $P(^(0),"^",10)=N,^PRC(411,"C",N,N)=""
 W !,"DONE",!!
