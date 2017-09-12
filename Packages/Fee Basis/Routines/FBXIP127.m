FBXIP127 ;ALB/DEP-Pre-Install Routine for FB*3.5*127 ; 5/3/13 11:31am
 ;;3.5;FEE BASIS;**127**;JAN 30, 1995;Build 9
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
POST ; Enrty point for routine
 N DA,DFN,DIK,FB0,FBAUTH,FBFDC,FBMST,FBTYPE,FBJ,Y
 S ^XTMP("FB127",0)=$$FMADD^XLFDT(DT,+90)_"^"_DT
 S $P(^XTMP("FB127",0),"^",3)="MRA transactions pointing to deleted Authorizations."
GO ; Sort through "Pending" MRA entries. 
 S FBJ=0 F  S FBJ=$O(^FBAA(161.26,"AC","P",FBJ)) Q:FBJ'>0  S FB0=$G(^FBAA(161.26,FBJ,0)) D
 .D CHECK
 Q
CHECK ;Checking Pt. info for valid authorizations.
 ; patient info;input:Y(0);output:FBDOB,FBFI,FBFLNAM,FBLNAM,FBMI,FBNAME,FBSEX,FBSSN
 S DFN=$P(FB0,U)
 S FBAUTH=$P(^FBAA(161.26,FBJ,0),"^",3) I FBAUTH']"" D DELMRA
 I '$D(^FBAAA(DFN,1,FBAUTH,0)) D DELMRA
 Q
DELMRA ; Deletes MRA entry that points to non-existent authorization.
 S ^XTMP("FB127",FBJ)=^FBAA(161.26,FBJ,0)
 S DIK="^FBAA(161.26,",DA=FBJ
 D ^DIK
 Q
