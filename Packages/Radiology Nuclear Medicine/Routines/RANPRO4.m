RANPRO4 ;BPFO/CLT - RADIOLOGY NEW PROCEDURE UTILITIES ; 27 Oct 2016  4:32 PM
 ;;5.0;Radiology/Nuclear Medicine;**127**;Mar 16, 1998;Build 119
 ;
 Q
EN(RADA) ;PRIMARY ENTRY POINT
 N DIR,RATYPE,RAFAC,RAFN,RACODE,RAGOLD,RAMATCH,RANM,RANOT,RAPLUSY,RAPROIEN,XMDUN,RANEWPRO
 N P1,P2,RA901
 I $G(DA)'="",$G(RADA)="" S RADA=DA
 S RANM=RAPNM,^XTMP("RAMAIN4",$J,"RAEND")=0,RADA=+RADA
GOOD ;ACCEPT ENTRY AND ASSIGN CPT
 S RATYPE=$P(^RAMRPF(71.11,RADA,0),U,6) D:RATYPE'="D"
 .W !!?3,"The type of this exam has been chosen not to be DETAILED.","  An NTRT process",!?3,"will not be initiated.  And no MRPF matching will be performed.",!
 .Q
 Q:RATYPE'="D"
 K DIR,DIR(0),DIR("A"),DIR("B")
 I $G(RA7111DA)="" S RA7111DA=$G(^TMP("RA7111DA",$J))
 K DIR S DIR(0)="Y",DIR("A")="Are you sure you are entering "_$P(^RAMRPF(71.11,RA7111DA,0),U,1)_" as a new procedure"
 ;K DIR S DIR(0)="Y",DIR("A")="Are you sure you are entering "_$P(^RAMRPF(71.11,1,0),U,1)_" as a new procedure"
 S RASEED=" " S RASEED=$S($P($G(^RAMRPF(71.98,1,0)),U,10)'="Y":" not ",1:" ")
 S DIR("A",1)="This entry will"_RASEED_"be submitted for NTRT processing."
 S DIR("B")="YES"
 W ! D ^DIR S:Y=0 ^XTMP("RAMAIN4",$J,"RAEND")=1 G:^XTMP("RAMAIN4",$J,"RAEND")=1 END
CPTEN ;Enter the CPT code
 I $G(RAX)="QUIT"!(X["^") G END
 W !!,"The CPT code is needed to match to an entry within the MASTER",!,"RADIOLOGY PROCEDURE file."
 I $G(RACPT)'="" W !!,"The CPT code for this procedure is ",RACPT,"."
 I $G(RACPT)="" K DIR S DIR(0)="71,9^^",DIR("A")="Enter the CPT code for this procedure, if the CPT code is known"
 I $G(RACPT)="" K DIRUT,DIROUT,DUOUT W ! D ^DIR I $G(DIRUT)=1  G END
 S:X>0 $P(^RAMRPF(71.11,RADA,0),U,9)=X,RACPT=X
 S DA=RADA D MRPF^RANPRO5 S RAGOLD=RAMATCH
 I $D(DUOUT)!($G(Y(0))="")!($G(RANQUIT)=1) W !!,*7,"No MRPF match made.",!! G END
 I $G(RAPROIEN)'="",($G(RANQUIT)'=1),$D(^RAMIS(71,"MRPF",$S($G(RAPROIEN)'="":RAPROIEN,1:0))) S RAMTCH=1 D MTCH^RANPROU2
 G:$G(RANQUIT)=1 END
 I Y(0)'["NONE LISTED" S DA=RADA,DIE="^RAMRPF(71.11,",DIE(0)="L",DR="900///"_$P($G(^RAMRPF(71.99,RAPROIEN,0)),U,1)_";902///"_DT_";903///"_$P($G(^RAMRPF(71.99,RAPROIEN,0)),U,4) S DA=RADA D ^DIE D
 . I $G(RAPROIEN)'="" W !?3,"You have mapped this procedure to "_$P($G(^RAMRPF(71.99,RAPROIEN,0)),U,1) Q
 I $G(Y(0))["NONE LISTED" D
 . S DA=RADA,DIE="^RAMIS(71,",DIE(0)="L"
 . S DR="901///" S RA901=$S($P($G(^RAMRPF(71.98,1,0)),U,10)="Y":"Y",1:"")
 . S DR=DR_RA901_";902///"_DT D ^DIE
 . Q
 S $P(^RAMRPF(71.11,RADA,"NTRT"),U,3)=DT,^RAMRPF(71.11,"CREAT",DT,RADA)=""
 I $P($G(^RAMRPF(71.98,1,0)),U,10)'="Y" S $P(^RAMRPF(71.11,RADA,"NTRT"),U,3)=""
MSG ;SEND A MESSAGE TO GATEKEEPER
 I $P($G(^RAMRPF(71.98,1,0)),U,10)'="Y" Q RADA
 N XMSUB,XMY,XMTEXT,RATXT Q:$P($G(^RAMRPF(71.11,RADA,"NTRT")),U,1)'="" RADA
 S XMSUB="NEW RADIOLOGY PROCEDURE"
 S XMY(DUZ)=""
 I $P($G(^RAMRPF(71.98,1,0)),U,2)'="" S XMY($P(^RAMRPF(71.98,1,0),U,2))=""
 S RATXT(1)="A new Radiology procedure has been entered."
 S RATXT(3)="This procedure will be submitted for NTRT processing."
 S RATXT(4)=" "
 S RATXT(5)=" "
 ;S RATXT(7)=" "
 I $G(RA7111DA)="" S RA7111DA=$G(^TMP("RA7111DA",$J))
 S RATXT(7)="Procedure Name: "_$P(^RAMRPF(71.11,RA7111DA,0),U,1)
 ;S RATXT(7)="Procedure Name: "_$P(^RAMRPF(71.11,1,0),U,1)
 S RATXT(8)="CPT: "_$P($G(^RAMRPF(71.11,RADA,0)),U,9)
 S XMTEXT="RATXT(" D ^XMD
 I $P($G(^RAMRPF(71.98,1,0)),U,10)'="Y" Q RADA
 Q:$P($G(^RAMRPF(71.11,RADA,"NTRT")),U,1)'="" RADA
 S RANMSG=1
 G END
MSG1 ;MESSAGE TO NTRT
 ;I $P($G(^RAMRPF(71.98,1,0)),U,10)'="Y" Q RADA
 I $P($G(^RAMRPF(71.98,1,0)),U,10)'="Y" Q
 ;N XMSUB,XMY,XMTEXT,RATXT Q:$P($G(^RAMIS(71,RADA,"NTRT")),U,1)'="" RADA
 N XMSUB,XMY,XMTEXT,RATXT,XMDUN,XMDUZ,XMZ,RAFAC,RAFN
 I $P($G(^RAMIS(71,RADA,"NTRT")),U,1)'="" Q
 S RAFAC=$$KSP^XUPARAM("INST"),RAFAC=$$NS^XUAF4(RAFAC)
 ;S RAFN=$P(RAFAC,U,1),RAFAC=$P(RAFAC,U,2),$P(^RAMRPF(71.11,RADA,"NTRT"),U,2)="Y"
 N DA,DIE,DR S DIE="^RAMIS(71,",DR="901///Y",DA=RADA D ^DIE K DA,DIE,DR
 S RAFN=$P(RAFAC,U,1),RAFAC=$P(RAFAC,U,2)
 ;S RAFN=$P(RAFAC,U,1),RAFAC=$P(RAFAC,U,2),$P(^RAMIS(71,RADA,"NTRT"),U,2)="Y"
 S XMSUB="NEW RADIOLOGY PROCEDURE"
 S XMY("G.RADIOLOGY NTRT@FORUM.DOMAIN.EXT")=""
 S XMY("G.RADNTRT")=""
 S XMDUZ("G.RADNTRT")=""
 S XMY(DUZ)=""
 I $P($G(^RAMRPF(71.98,1,0)),U,2)'="" S XMY($P(^RAMRPF(71.98,1,0),U,2))=""
 ;S XMY("G.RADIOLOGY NTRT@FORUM.DOMAIN.EXT")=""
 S RATXT(1)="A new Radiology procedure has been entered at "_RAFN
 S RATXT(2)=" "
 S RATXT(3)="Facility Name/number: "_RAFN_" / "_RAFAC
 S RATXT(4)=" "
 I $G(RA7111DA)="" S RA7111DA=$G(^TMP("RA7111DA",$J))
 S RATXT(5)="Procedure name: "_$P(^RAMIS(71,RADA,0),U,1)
 ;S RATXT(5)="Procedure name: "_$P(^RAMRPF(71.11,RA7111DA,0),U,1)
 ;S RATXT(5)="Procedure name: "_$P(^RAMRPF(71.11,1,0),U,1)
 S RATXT(6)=" "
 S RATXT(7)="CPT code: "_$P($G(^RAMIS(71,RADA,0)),U,9)
 ;S RATXT(7)="CPT code: "_$P($G(^RAMRPF(71.11,RADA,0)),U,9)
 S RATXT(8)="Local IEN: "_RADA
 S RATXT(9)="For questions or notification respond to: "_"G.RADNTRT@"_$$KSP^XUPARAM("WHERE")
 S RATXT(10)="For NTRT results respond to: "_"S.RANEWPRO@"_$$KSP^XUPARAM("WHERE")
 ;I $P($G(^RAMRPF(71.98,1,0)),U,9)="Y" D XML G END
 S $P(^RAMIS(71,RADA,"NTRT"),U,4)=DT
 ;S $P(^RAMRPF(71.11,RADA,"NTRT"),U,4)=DT
 S XMTEXT="RATXT(" D ^XMD
 ;S $P(^RAMIS(71,RADA,"NTRT"),U,4)=DT
 I $P($G(^RAMRPF(71.98,1,0)),U,9)="Y" D XML
 K XMSUB,XMY,XMTEXT,RATXT,XMDUN,XMDUZ,XMZ,RAFAC,RAFN
 Q
 ;
XML ; NTRT message for ISAAC
 ; Need P1 ISAAC SCHEMA NAME
 ; Need P2 ISAAC SCHEMA PATH
 ; get the schemea name and the schema path
 N P1,P2,A,C
 S P1=$$GET1^DIQ(71.98,"1,",11.6)
 S P2=$$GET1^DIQ(71.98,"1,",7)
 S A=$TR(P1,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 I P1'=""&($E(A,($L(A)-4),$L(A)))'=".XSD" S P1=P1_".XSD"
 I P2'="" D  ;<
 . I $E(P2,1,2)'="//" S P2="//"_P2
 . I $E(P2,$L(P2))="/" S P2=P2_$E(P2,1,($L(P2)-1))
 S A="uri:"_P2_P1
 S XMSUB="NEW RADIOLOGY PROCEDURE"
 K RATXT
 S RATXT(1)=$$XMLHDR^MXMLUTL()
 S RATXT(2)="<DATAEXTRACTS xmlns="""_A_""" xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance"""
 S RATXT(3)=">"
 S RATXT(4)="<RAD_NTRT>"
 S RATXT(5)="<Facility_Name/number>"_RAFN_" / "_RAFAC_"</Facility_Name/number>"
 S RATXT(6)="<Facility_Group_e-mail>"_"G.RADNTRT@"_$$KSP^XUPARAM("WHERE")_"</Facility_Group_e-mail>"
 S RATXT(7)="<Procedure_name>"_RANM_"</Procedure_name>"
 S RATXT(8)="<CPT_code>"_$P($G(^RAMIS(71,RADA,0)),U,9)_"</CPT_code>"
 ;S RATXT(8)="<CPT_code>"_$P($G(^RAMRPF(71.11,RADA,0)),U,9)_"</CPT_code>"
 S RATXT(9)="<Local_IEN>"_RADA_"</Local_IEN>"
 S RATXT(10)="<NTRT_results_response_e-mail>"_"S.RANEWPRO@"_$$KSP^XUPARAM("WHERE")_"</NTRT_results_response_e-mail>"
 S RATXT(11)="</RAD_NTRT>"
 S RATXT(12)="</DATAEXTRACTS>"
 S RAXTMPNM=XMSUB
 ;D XMLSND^RAXMLSND(RAXTMPNM)
 N RADUZ,RA71IEN,RAS
 S RADUZ=DUZ,RA71IEN=RADA,RAS=""
 D EN^RAXMLSND
 K RADUZ,RA71IEN,RAS,RATXT
 Q
 ;
DEACT ;BLOCK INACTIVATION DATE
 Q
 I $P($G(^RAMRPF(71.98,1,0)),U,3)'="" D
 . S X1=DT,X2=$P(^RAMRPF(71.98,1,0),U,3)
 . D C^%DTC
 . S ^RAMRPF(71.11,RADA,"I")=X,$P(^RAMRPF(71.11,RADA,"NTRT"),U,2)="Y"
 Q
END ;KILL LOCAL VARIABLES AND END
 K RATXT,XMZ,XMDUN,XMDUZ,X,Y
 Q $G(RANEWPRO)
 ;
MSGRAN(RADA) ; entry from RANPRO after file to 71 to send NTRT message
 G MSG1
