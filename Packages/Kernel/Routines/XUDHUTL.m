XUDHUTL ;ISF/RWF - Some device Utilities. ;09/02/10  17:22
 ;;8.0;KERNEL;**543**;Jul 10, 1995;Build 15
 Q
 ;
PTEST ;Send a test pattern to a printer
 N X,Y,DIR,DIRUT,DUOUT,DTOUT,XUDH1
 S DIR(0)="N^1:66",DIR("A")="How Many Lines" D ^DIR Q:$D(DIRUT)
 S XUDH1=Y,X("XUDH1")="",%ZIS="QM"
 D EN^XUTMDEVQ("PT1^XUDHUTL","Printer Test",.X,.%ZIS)
 Q
 ;
PT1 ;Do the print
 N X,I
 U IO
 F X=XUDH1:-1 W ! Q:'X  F I=1:1:IOM W $C(I+X#96+32)
 Q
