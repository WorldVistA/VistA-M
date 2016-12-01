FBNHEDAD ;AISC/GRR - EDIT ADMISSION TYPE FOR NURSING HOME ;1/22/15  14:49
 ;;3.5;FEE BASIS;**154**;JAN 30, 1995;Build 12
 ;;Per VA Directive 6402, this routine should not be modified.
RD1 D GETVET^FBAAUTL1 G:DFN']"" Q
RD2 S DIC("S")="I $P(^(0),U,3)=""A""&($P(^(0),U,2)=DFN)",DIC="^FBAACNH(",DIE=DIC,DIC(0)="AEQMZ",DLAYGO=162.3,DIC("A")="Select Admission Date/Time: " D ^DIC K DIC,DLAYGO G RD1:X="^"!(X=""),RD2:Y<0 S DA=+Y
 S DR="5;8" D ^DIE
 D
 . N FB,FBX,DTOUT
 . S FB(161)=$S(DA:$P($G(^FBAACNH(DA,0)),"^",10),1:"")
 . Q:'FB(161)
 . I $D(^FBAAA(DFN,1,FB(161),0)) S FB(78)=+$P(^(0),"^",9)
 . Q:'$G(FB(78))
 . S FBX=$$ADDUA^FBUTL9(162.4,FB(78)_",","Edit CNH admission.")
 . I 'FBX W !,"Error adding record in User Audit. Please contact IRM."
 G RD1:'$D(DTOUT)
Q K DIC,DIE,DR,DA,DFN,FBTYPE,FTP,Y,X,FBPROG
 Q
