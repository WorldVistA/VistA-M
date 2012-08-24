FBAACO2 ;AISC/GRR-PAYMENT PROCESS FOR DUPLICATE ;7/13/2003
 ;;3.5;FEE BASIS;**4,55,61,77,116,122,133,108**;JAN 30, 1995;Build 115
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
RD S DIR(0)="Y",DIR("A")="Want this payment stored as a Medical Denial",DIR("B")="YES",DIR("?")="Enter 'Yes' to store payment entry as a denial and send a Suspension letter.  Enter 'No' to have nothing happen." D ^DIR K DIR Q:$D(DIRUT)!('Y)
 S FBDEN=1 Q
FILE ;files sp multiple entry
 K DR S TP="" I $G(FBDEN) S FBAMTPD=0
 S DR="49///^S X=$G(FBCSID);50///^S X=$G(FBFPPSC);I $G(FBDEN) S Y=1;48;47//1;S FBUNITS=X;S:$G(FBFPPSC)="""" Y=""@11"";S FBX=$$FPPSL^FBUTL5();S:FBX=-1 Y=0;51///^S X=FBX;@11"
 ; fb*3.5*116 do not enable different interest indicator values at line item level; interest indicator set at invoice level
 ;S DR(1,162.03,1)="D PPT^FBAACO1();34///^S X=$G(FBAAMM1);D POS^FBAACO1;S:'$G(FBHCFA(30)) Y=0;1;S J=X;I $G(FBDEN) S Y=2;D FEE^FBAACO0;44////^S X=FBFSAMT;45///^S X=FBFSUSD;2///^S X=FBAMTPD;S K=X"
 S DR(1,162.03,1)="34///^S X=$G(FBAAMM);D POS^FBAACO1;S:'$G(FBHCFA(30)) Y=0;1;S J=X;I $G(FBDEN) S Y=2;D FEE^FBAACO0;44////^S X=FBFSAMT;45///^S X=FBFSUSD;2///^S X=FBAMTPD;S K=X"
 ;S DR(1,162.03,2)="S:J-K=0 Y=6;3//^S X=$S(J-K:J-K,1:"""");S:'X Y=6;3.5///^S X=DT;@4;4;I X']"""" D SC^FBAACO3;S:X'=4 Y=6;22;6////^S X=DUZ"
 S DR(1,162.03,2)="S FBX=$$ADJ^FBUTL2(J-K,.FBADJ,2);S:FBX=0 Y=0;6////^S X=DUZ"
 S DR(1,162.03,3)="7////^S X=FBAABE;8////^S X=BO;13///^S X=FBAAID;14///^S X=FBAAIN;33///^S X=FBAAVID;I $G(FBDEN) S FBTST=1"
 I '$G(FBDEN) D
 .N FBCSVSTR S FBCSVSTR="I X]"""" S:$$INPICD9^FBCSV1(X,"""",$G(FBAADT)) Y=""@1"";"
 .S DR(1,162.03,4)="S:$$EXTPV^FBAAUTL5(FBPOV)=""01"" Y=""@1"";S:FB7078]""""!($D(FB583)) Y=30;@5;28R;S:$$INPICD9^FBCSV1(X,"""",$G(FBAADT)) Y=""@5"";30////^S X=FBHCFA(30);31;32R;S Y=15;@1;28;"_FBCSVSTR_"30////^S X=FBHCFA(30);31"
 .S DR(1,162.03,5)="15///^S X=FBPT;S FBX=$$RR^FBUTL4(.FBRRMK,2);S:FBX=0 Y=0"
 .S DR(1,162.03,6)="16////^S X=FBPOV;17///^S X=FBTT;18///^S X=FBAAPTC;23////^S X=FBTYPE;26////^S X=FBPSA;S:$D(FBV583) Y=""@2"";27////^S X=FB7078;S Y=""@99"";@2;27////^S X=FBV583;@99;S FBTST=1;54////^S X=FBCNTRP"
 .S DR(1,162.03,7)="73;74;75;58;59;60;61;62;63;64;65;66;67;76;77;78;79;68;69" ;FB*3.5*122 Line Item Provider information ;FB*3.5*133 Provider Information
 S DIE="^FBAAC("_DFN_",1,"_FBV_",1,"_FBSDI_",1,"
 S DA(3)=DFN,DA(2)=FBV,DA(1)=FBSDI,DA=FBAACPI
 D LOCK^FBUCUTL("^FBAAC("_DFN_",1,"_FBV_",1,"_FBSDI_",1,",FBAACPI,1)
 D
 . N ICDVDT S ICDVDT=$G(FBAADT) D ^DIE
 I '$D(DTOUT),$G(FBTST) D
 . D FILEADJ^FBAAFA(FBAACPI_","_FBSDI_","_FBV_","_DFN_",",.FBADJ)
 . D FILERR^FBAAFR(FBAACPI_","_FBSDI_","_FBV_","_DFN_",",.FBRRMK)
 L -^FBAAC(DFN,1,FBV,1,FBSDI,1,FBAACPI)
 I $D(DTOUT) D KILL Q
 I '$G(FBTST),$G(DA) S DIR(0)="YA",DIR("A")="Entering an '^' will delete "_$S($G(FBDEN):"denial",1:"payment")_".  Are you sure you want to delete? ",DIR("B")="No" D ^DIR K DIR G FILE:'$D(DIRUT)&('Y) D KILL Q
 K FBTST,FBDEN,DIE,DR,DA,FBX
 I $D(FBDL) S FBAAOUT=1 Q
 Q
KILL S DIK=DIE D ^DIK K DIE,DIK I '$G(FBCNP) D Q^FBAACO S FBAAOUT=1
 W !,"Deleted" Q
