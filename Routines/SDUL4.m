SDUL4 ;ALB/MJK - Screen Malipulation Utilities ; 12/1/91
 ;;5.3;Scheduling;;Aug 13, 1993
 ;
NEXT ; -- display next screen (NX)
 N SDULSTO,I,LN
 I SDULBG+SDUL("LINES")>SDULCNT W *7 G NEXTQ
 S SDULBG=SDULBG+SDUL("LINES")
 S SDULSTO=SDULST
 I SDULCC D LST,SCROLL D
 .S DX=0,DY=SDUL("BM")-1 X IOXY
 .S I=SDULSTO+1 F LN=1:1:SDUL("LINES") W !,$G(@SDULAR@(+$$GET(I),0)) S I=I+1
 .S SDULBCK="" D PLUS,RESET
 D PGUPD
NEXTQ D FINISH Q
 ;
PREV ; -- display previous screen (BU)
 N I,LN,X,Y,SDULBGO
 I SDULBG=1 W *7 G PREVQ
 S Y=SDULBG-SDUL("LINES")
 S SDULBGO=SDULBG,SDULBG=$S(Y<1:1,1:Y)
 I SDULCC D LST,SCROLL D
 .S DX=0,DY=SDUL("TM")-1
 .S I=SDULBGO-1 F LN=1:1:SDUL("LINES") D IOXY W $G(@SDULAR@(+$$GET(I),0)) Q:I=1  S I=I-1
 .S SDULBCK="" D PLUS,RESET
 D PGUPD
PREVQ D FINISH Q
 ;
FIRST ; -- display first screen (FS)
 I SDULBG=1 W *7 G FIRSTQ
 S SDULBG=1
 I SDULCC D LST,PAINT
 D PGUPD
FIRSTQ D FINISH Q
 ;
LAST ; -- display last screen (LS)
 N Y,I
 I SDULCNT'>SDUL("LINES") W *7 G LASTQ
 ; first line of the last screen :=
 ; (# of full screens less 1 if last screen is also full) x # lines per screen) + 1 line 
 S Y=(((SDULCNT\SDUL("LINES"))-'(SDULCNT#SDUL("LINES")))*SDUL("LINES"))+1
 I Y=SDULBG W *7 G LASTQ
 S SDULBG=Y
 I SDULCC D LST,PAINT
 D PGUPD
LASTQ D FINISH Q
 ;
UP ; -- display last screen (UP)
 N Y
 S Y=SDULBG-1
 I Y<1 W *7 G UPQ
 S SDULBG=Y D LST
 I SDULCC D SCROLL S DX=0,DY=SDUL("TM")-1 D IOXY W $G(@SDULAR@(+$$GET(SDULBG),0)) D PLUS,RESET
 D PGUPD
UPQ D FINISH Q
 ;
DOWN ; -- display next line (DN)
 N Y
 S Y=SDULST+1
 I Y>SDULCNT W *7 G DOWNQ
 S SDULBG=SDULBG+1,SDULST=Y
 I SDULCC D SCROLL S DX=0,DY=SDUL("BM")-1 X IOXY W !,$G(@SDULAR@(+$$GET(SDULST),0)) D PLUS,RESET
 D PGUPD
DOWNQ D FINISH Q
 ;
FINISH ; -- finish action
 S SDULBCK=$S(SDULCC:"",1:"R")
 Q
 ;
PAINT ; 
 N I,LN,X D SCROLL
 I $E(IOST,1,4)="C-VT" S DX=0,DY=SDUL("TM")-1 X IOXY W *27,*91,SDUL("LINES"),*77
 S I=SDULBG F LN=1:1:SDUL("LINES") S DX=0,DY=SDUL("TM")+LN-2 D IOXY W $G(@SDULAR@(+$$GET(I),0)) S I=I+1
 S SDULBCK="" D PLUS,RESET
 Q
 ;
IOXY ; -- position cursor ; insert line ; cr
 W ! X IOXY W IOIL,$C(13)
 Q
 ;
RE ; -- re-display current screen (RE)
 D REFRESH^SDUL S SDULBCK=""
 Q
 ;
RESET ; -- reset scrolling region to bottom of screen
 S DX=0,DY=SDUL("BM")+1 X IOXY W IOEDEOP
 S IOTM=SDUL("BM")+2,IOBM=IOSL W IOSC W @IOSTBM W IORC
 D UND($$LOWER^SDUL1($$NOW^SDUL1),31,1,21,0)
 I $D(SDULBCK) S DX=0,DY=SDUL("BM") X IOXY
 Q
 ;
SCROLL ; -- set scrolling region to list area
 S IOTM=SDUL("TM"),IOBM=SDUL("BM") W IOSC W @IOSTBM W IORC
 Q
 ;
LST ; -- compute last line on screen
 N I
 S I=SDULBG+SDUL("LINES")-1,SDULST=$S($D(@SDULAR@(+$$GET(I),0)):I,1:SDULCNT)
 Q
 ;
GET(LNUM) ; -- get actual line number (may be different if indexed)
 Q $S(SDUL(0)["I":$G(@SDULIDX@(LNUM)),1:LNUM)
 ;
PLUS ; -- add plus indicators to screen
 N UP,DN
 S UP=(SDULBG'=1),DN=$S('$D(SDULST):0,SDUL(0)["I":$O(@SDULIDX@(+SDULST))>0,1:$O(@SDULAR@(+SDULST))>0)
 I UP'=SDULUP S SDULUP=UP D UND($S(UP:"+",1:" "),1,SDUL("TM")-1,1)
 I DN'=SDULDN S SDULDN=DN D UND($S(DN:"+",1:" "),1,SDUL("BM")+1,1)
 Q
 ;
PGUPD ; -- update page var and screen
 N P
 S P=$$PAGE(SDULBG,SDUL("LINES")) G PGUPDQ:P=SDULPGE
 S SDULPGE=P
 D:SDULCC UND($J(P,3),71,1,3,0)
PGUPDQ Q
 ;
PAGE(BEG,LINES) ; -- calc page #
 Q (BEG\LINES)+((BEG#LINES)>0)
 ;
UND(STR,X,Y,LEN,ERASE) ;
 W IOUON,$C(13) D INSTR^SDUL1(STR,X,Y,LEN,+$G(ERASE)) W $C(13),IOUOFF
 Q
