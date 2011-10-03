FBAAPP0 ;AISC/GRR-ENTER FEE PHARMACY DETERMINATION CONT ;4/27/2005
 ;;3.5;FEE BASIS;**61,91**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
HELPI W !!,"Enter Invoice number you wish to make a determination on.  Must",!,"be an invoice which is 'Pending Determination' status." G RDIN^FBAAPP
ALRDY W !,*7,"Someone is editing that invoice now!" G RDIN^FBAAPP
 ;
NO1 ;ASK PHARMACIST TO SPECIFY ADJUSTMENT REASON
 N FBX
 ; prompt for adjustments
 S FBX=$$ADJ^FBUTL2($P(FBY(0),U,4),.FBADJ,2) Q:FBX=0
 ; prompt for remittance remarks
 S FBX=$$RR^FBUTL4(.FBRRMK,2) Q:FBX=0
 Q
 ;
GOON ; entry point when prescription was denied by pharmacy
 S STAT=3,$P(FBY(0),"^",11)=0,$P(FBY(0),"^",14)=DUZ,$P(FBY(0),"^",15)=DT,$P(FBY(0),"^",9)=3,$P(FBY(0),"^",16)=0
RSET ; entry point when prescription was not denied by pharmacy
 S $P(FBY(0),"^",21)=$S(FBAAGP="Yes":"Y",FBAAGP="No":"N",1:"")
 S $P(FBY(0),"^",22)=FBAAPR
 S ^FBAA(162.1,FBJ,"RX",FBK,0)=FBY(0)
 K ^FBAA(162.1,FBJ,"RX","AC",1,FBK) S ^FBAA(162.1,FBJ,"RX","AC",STAT,FBK)="",$P(^FBAA(162.1,FBJ,0),"^",5)=$S($D(^FBAA(162.1,FBJ,"RX","AC",1)):1,$D(^(2)):2,$D(^(3)):3,1:0)
 I '$D(^FBAA(162.1,FBJ,"RX","AC",1)) K ^FBAA(162.1,"AC",1,FBJ) S ^FBAA(162.1,"AC",2,FBJ)=""
 I $D(FBADJ) D
 . D FILEADJ^FBRXFA(FBK_","_FBJ_",",.FBADJ) ; file adjustments
 . D FILERR^FBRXFR(FBK_","_FBJ_",",.FBRRMK) ; file remittance remarks
 Q
