PRCH1A3 ;WISC/PLT-PRCH1A continued ;9/8/98  11:10
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 QUIT  ;invalid entry
 ;
RC ;entry point - prch1d
 ;if the order is Simplified or Detailed but receiving is not required,
 ;confirm receipt with the user; otherwise check file #442,
 ;node 11 before asking the user any questions.
 ;
 S PRCE=^PRC(442,PRCRI(442),0),PRCCP=$P($G(^(23)),"^",16),PRCR=$P($G(^(23)),"^",15)
 I PRCR="N",$P($G(^PRC(442,PRCRI(442),23)),"^",11)="S" D EDIT^PRC0B(.X,"440.6;^PRCH(440.6,;"_PRCRI(440.6),43) I $G(X)=-1 D EXIT QUIT
 I PRCR="N",$P($G(^PRC(442,PRCRI(442),23)),"^",11)="P" D EDIT^PRC0B(.X,"440.6;^PRCH(440.6,;"_PRCRI(440.6),43) I $G(X)=-1 D EXIT QUIT
 ;
 I PRCR="Y",$P($G(^PRC(442,PRCRI(442),23)),"^",11)="P" D  I $G(X)=-1 D EXIT QUIT
 . D CHKREC I $P($G(^PRCH(440.6,PRCRI(440.6),1)),"^",3)="Y" Q
 . D EDIT^PRC0B(.X,"440.6;^PRCH(440.6,;"_PRCRI(440.6),"43////N") I $G(X)=-1 D EXIT QUIT
 ;
 ;See if the order was entered by a PA with MOP=25 and confirm receipt.
 I PRCR="Y",$P($G(^PRC(442,PRCRI(442),23)),"^",11)="" D  I $G(X)=-1 D EXIT QUIT
 . D CHKREC I $P($G(^PRCH(440.6,PRCRI(440.6),1)),"^",3)="Y" Q
 . D EDIT^PRC0B(.X,"440.6;^PRCH(440.6,;"_PRCRI(440.6),"43////N")
 ;
 I PRCR="N",$P($G(^PRC(442,PRCRI(442),23)),"^",11)="" D  I $G(X)=-1 D EXIT QUIT
 . D EDIT^PRC0B(.X,"440.6;^PRCH(440.6,;"_PRCRI(440.6),43)
 ;
 ;Check old orders where receiving required was not specified by the PA.
 I PRCR="",$P($G(^PRC(442,PRCRI(442),23)),"^",11)="" S PRCR="Y" D  I $G(X)=-1 D EXIT QUIT
 . D CHKREC I $P($G(^PRCH(440.6,PRCRI(440.6),1)),"^",3)="Y" Q
 . D EDIT^PRC0B(.X,"440.6;^PRCH(440.6,;"_PRCRI(440.6),"43////N")
 ;
 ;Check PC Direct Delivery Orders. These orders are not received at the
 ;station.
 I PRCR="",$P($G(^PRC(442,PRCRI(442),23)),"^",11)="P" D EDIT^PRC0B(.X,"440.6;^PRCH(440.6,;"_PRCRI(440.6),"43////Y") I $G(X)=-1 D EXIT QUIT
 ;
 W !,"WARNING: If a credit or additional charge is expected against this order number"
 W !,"do NOT respond YES."
 D EDIT^PRC0B(.X,"440.6;^PRCH(440.6,;"_PRCRI(440.6),"44;15////R;45////"_DUZ) I $G(X)=-1 D EXIT QUIT
 D EDIT^PRC0B(.X,"440.6;^PRCH(440.6,;"_PRCRI(440.6),"46///T;41////"_PRCRI(442)_";42////"_PRCR)
 S PRCRI(410)=$P(^PRC(442,PRCRI(442),0),"^",12),PRCF=$P($G(^(7)),"^",2)
 I PRCRI(410) S PRCCOA=$P($G(^PRCS(410,PRCRI(410),4)),"^",8)
 I '$G(PRCEDRM) D EDIT^PRC0B(.X,"440.6;^PRCH(440.6,;"_PRCRI(440.6),"18////"_PRCCOA_";19////"_PRCF)
 S PRCF=^PRCH(440.6,PRCRI(440.6),1),PRCST=$S($P(PRCF,U,2)]"":$P(PRCF,U,2),1:"N")_$S($P(PRCF,U,3)]"":$P(PRCF,U,3),1:"N")_$S($P(PRCF,U,4)]"":$P(PRCF,U,4),1:"N")
 I $E(PRCST)="N" S PRCSTC=$E("NC",$E(PRCST,2)="Y"+1)_$E(PRCST,3)
 E  S PRCSTC=$S($D(^PRC(442,PRCRI(442),2,"C"))&$D(^PRC(442,PRCRI(442),11)):"P",'$D(^PRC(442,PRCRI(442),11)):"N",1:"C")_$E(PRCST,3)
 S PRCST=$P($T(@PRCSTC),";",3,4),PRCST=$S($D(^PRC(442,PRCRI(442),6)):+$P(PRCST,";",2),1:+$P(PRCST,";"))
 D EDIT^PRC0B(.X,"442;^PRC(442,;"_PRCRI(442),"58///T;.5///"_PRCST)
 I $P(PRCF,"^",4)="N" D
 . S PRCVAL="" D EDIT^PRC0B(.X,"442;^PRC(442,;"_PRCRI(442),"44Are you going to dispute this charge amount?//NO;S PRCVAL=X W:X?1""Y"".U !,""You must file a disputed claim form with Purchase Card Company.""")
 . I PRCVAL?1"Y".U D EDIT^PRC0B(.X,"440.6;^PRCH(440.6,;"_PRCRI(440.6),"15////D")
 . QUIT
 I $P(PRCF,"^",4)="Y" D EDIT^PRC0B(.X,"440.6;^PRCH(440.6,;"_PRCRI(440.6),"15////R"),EDIT^PRC0B(.X,"442;^PRC(442,;"_PRCRI(442),"44////N")
 I $P(PRCF,"^",4)="Y",PRCRI(410) D
 . N A,B
 . S A=0,B=0 F  S A=$O(^PRCH(440.6,"PO",PRCRI(442),A)) QUIT:'A  S B=B+$P(^PRCH(440.6,A,0),"^",14)
 . I B-PRCCOA D EDIT^PRC0B(.X,"410;^PRCS(410,;"_PRCRI(410),"27////"_B)
 . S PRCRI(410)=0
 . F  S PRCRI(410)=$O(^PRC(442,PRCRI(442),13,PRCRI(410))) QUIT:'PRCRI(410)  D:PRCRI(410) ERS410^PRC0G(PRCRI(410)_"^O")
 . QUIT
 D EDIT^PRC0B(.X,"442;^PRC(442,;"_PRCRI(442),"20")
 S A=$$DDA4406^PRCH0A(PRCRI(440.6)),B=$$DDA442^PRCH0A(PRCRI(442)),$P(B,"^",17)="",PRCBOC=$P(B,"^",21),$P(B,"^",33)=$P(A,"^",33)
 I '$G(PRCEDRM),A'=B D
 . I $E(PRCB,13,15)>490 D EN^DDIOL("Enter ET-Document by FMS-ON LINE!") QUIT
 . D EN^DDIOL("Generating ET-document to FMS...")
 . D ET^PRCH8A(.X,PRCRI(440.6)_"^"_PRCRI(442)_"^1^"_PRCBOC,"")
 . I X D EDIT^PRC0B(.X,"440.6;^PRCH(440.6,;"_PRCRI(440.6),"17////"_$P(X,"^"))
 . QUIT
EXIT D:$D(IOSTBM) SS(1,24),CS
 K FINALDEL,FPARTIAL,PARTIAL
 QUIT
 ;
SS(IOTM,IOBM) ;screen size a-top, b=bottom margin
 W @IOSTBM QUIT
 ;
MC(DX,DY) ;move cursor dx=column #, dy=row number
 S DX=DX-1,DY=DY-1 X IOXY QUIT
 ;
CS W @IOF QUIT
 ;
CHKREC ;Determine the receiving status of the order
 S PARTIAL=+$P($G(^PRC(442,PRCRI(442),11,0)),"^",3) Q:$G(PARTIAL)=0
 S:PARTIAL>0 FPARTIAL=$G(^PRC(442,PRCRI(442),11,PARTIAL,0))
 S:FPARTIAL]"" FINALDEL=$P($G(FPARTIAL),"^",9)
 I FINALDEL["F" D EDIT^PRC0B(.X,"440.6;^PRCH(440.6,;"_PRCRI(440.6),"43////Y")
 Q
 ;
STATUS ;order status 1-pos:n,p,c for receiving, 2-pos:n,y for final payment
NN ;;39;44
NY ;;24;29
PN ;;46;47
PY ;;32;34
CN ;;48;49
CY ;;50;51
 ;
