PRCB1A1 ;WISC/PLT-PRCB1A CONTINUED ; 06/16/94  2:16 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 QUIT  ;invalid entry
 ;
ED0 S X=$P($T(EDDR+1),";",3,999) S:C]""&(PRCAED-1) X=C_X
 F I=2:1 Q:$P($T(EDDR+I),";",3,999)=""  S X(1,420.01,I-1)=$P($T(EDDR+I),";",3,999)
 D EDIT^PRC0B(.X,PRCDI,"")
 I X=0 S PRCQT=2 QUIT
 I X=-1,PRCAED=1 D DELQ Q:PRCQT
 I $P(^PRC(420,PRCRI(420),1,PRCRI(420.01),0),"^",3)'["_/_"  D UNQCHK^PRCB1A(PRCK1,PRCK25D5,PRCK26,PRCK27,PRCK28,PRCK29) I PRCUNQ=1 D  G ED0
 . D EN^DDIOL("A single year fund control point must be unique!")
 . S C="1;25.2;" F A=25.5,26:1:29 S:PRCRQ(A) C=C_A_";S Y=0;"
 . Q
 ;required field check
 S C="1~1;4;14;21;" F I=25.5,26:1:29 S:PRCRQ(I) C=C_I_";"
 K A D PIECE^PRC0B(PRCDI,C,"I","A")
 S C="" F A=1 S:$G(A(PRCDD,PRCRI(PRCDD),A,"I"))="" C=C_A_";"
 F A=25.5,26:1:29 S:$G(A(PRCDD,PRCRI(PRCDD),A,"I"))=""&PRCRQ(A) C=C_A_";"
 F A=14 S:$G(A(PRCDD,PRCRI(PRCDD),A,"I"))="" C=C_A_";"
 I $$SFCP^PRC0D(PRCRI(420),PRCRI(420.01))'=2 F A=21 S:$G(A(PRCDD,PRCRI(PRCDD),A,"I"))="" C=C_A_";"
 S:C["21;" C=C_"S:$P($G(^PRC(420,DA(1),1,DA,0)),""^"",20)'=1 Y=""@899"";22;@899;"
 I C]"" K A D EN^DDIOL(" **** Missing Required Field(s) ****") S C=C_"S Y=0;" G ED0
 I $G(A(PRCDD,PRCRI(PRCDD),4,"I"))["N" D EN^DDIOL("Notify users of this control point that the control point is non-automated!")
 K A
 I PRCAED=1 D FCP^PRCD3A(PRCRI(420),$E($$DATE^PRC0C("T","E"),3,4),PRCRI(420.01)),EN^DDIOL("Note: The new fund control point was initialized to enable the current"),EN^DDIOL("fiscal year FMS RECORDS to post correctly.")
 QUIT
 ;
DELQ D YN^PRC0A(.X,.Y,"Delete this NEW entry","","No")
 I Y=1 D DELETE I PRCAED=-1 D EN^DDIOL(" **** NEW ENTRY DELETED ****") S PRCQT=3 QUIT
 D EN^DDIOL(" **** NEW ENTRY IS NOT DELETED ****")
 QUIT
 ;
DELETE ;delete 420.01
 D DELETE^PRC0B1(.X,PRCDI)
 S:X=1 PRCAED=-1
 QUIT
 ;
 ;
REQ ;get required fields
 S:$D(DA(1)) PRCRI(420)=DA(1) S:$D(DA) PRCRI(420.01)=DA
REQ1 N A,B
 S PRCRQ="" F B=25.5,26,27,28,29 S PRCRQ(B)=""
 QUIT:'PRCRI(420)!'PRCRI(420.01)
 S A=$G(^PRC(420,PRCRI(420),1,PRCRI(420.01),5))
 S PRCFUND=$P(A,"^"),PRCBBFY=$P(A,"^",8)
 Q:$G(PRCFUND)=""!($G(PRCBBFY)="")
 S A=$$FUND^PRC0C(PRCFUND,+$$DATE^PRC0C(PRCBBFY,"I"))
 D:+A
 . N PRC1,PRC2
 . F B="SPE","REV","GL" I $$REQ^PRC0C(+A,B,"JOB")="Y" S PRC2("JOB")="Y"
 . D DOCREQ^PRC0C(+A,"AB","PRC1")
 . D DOCREQ^PRC0C(+A,"SAB","PRC2")
 . S:$O(PRC1(""))]""!($O(PRC2(""))]"") PRCRQ=1
 . I PRCRQ F B="25.5^AO","26^PGM","27^FCPRJ","28^OC","29^JOB" S:$G(PRC1($P(B,U,2)))="Y"!($G(PRC2($P(B,U,2)))="Y") PRCRQ(+B)=1
 . QUIT
 QUIT
 ;
UNQMES N X D EN^DDIOL(" Warning: NOT UNIQUE for fund, a/o, program, fcp/prj, object class, and job!")
 D EN^DDIOL(" See fund control point "_$P($G(^PRC(420,PRCRI(420),1,PRCUQ,0)),"^",1))
 S PRCUNQ=1
 QUIT
 ;
EDDR ;edit string
 ;;.5;1;S:$G(PRCFUND)="" Y=0;25.2;@9255;S:'PRCRQ(25.5) Y="@926";25.5;@926;S:'PRCRQ(26) Y="@927";26;@927;S:'PRCRQ(27) Y="@928";27;@928;S:'PRCRQ(28) Y="@929";28;@929;S:'PRCRQ(29) Y="@904";29;@904;4;12;6;13;
 ;;7;8;14;31;32;S:$$SFCP^PRC0D(PRCRI(420),PRCRI(420.01))=2 Y="@999";21;S:$P($G(^PRC(420,DA(1),1,DA,0)),"^",20)'=1 Y="@999";22;@999;
 ;
