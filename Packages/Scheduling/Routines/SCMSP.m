SCMSP ;ALB/MTC - POST INIT ROUTINE;28-MAY-1996
 ;;5.3;Scheduling;**44**;AUG 13, 1993
 ;
HOPUP ;-- This function will update all the clinics in file #44 to
 ;   require Provider and Diagnosis for checkout. Using the "B"
 ;   x-ref a check will be performed to make sure that the location
 ;   is clinic then fields 26 (Ask provider@ CO) and 27 (Ask diagnosis
 ;   @ CO) will be set to 1 (REQUIRED).
 ;
 N SCX,SCY,SCZ,DIC,DIE,DA,DR,X,Y,%,%H,%I
 N MSGTXT,XMB,XMTEXT,XMY,XMDUZ,XMDT,XMZ
 ;
 S SCX=0
 F  S SCX=$O(^SC("B",SCX)) Q:SCX=""  S SCY=0 F  S SCY=$O(^SC("B",SCX,SCY)) Q:'SCY  D
 . S SCZ=$G(^SC(SCY,0)) Q:SCZ=""
 . I $P(SCZ,U,3)'="C" Q
 . I $$OCCA^SCDXUTL(SCY) Q
 . S DIE="^SC(",DA=SCY,DR="26///1;27///1" D ^DIE
 ;Get current date/time
 D NOW^%DTC
 ;Convert to external format
 S SCZ=$P(%,".",2)_"000000"
 S SCY=$E(SCZ,1,2)_":"_$E(SCZ,3,4)_":"_$E(SCZ,5,6)
 S SCX=%I(1)_"/"_%I(2)_"/"_(%I(3)+1700)_" @ "_SCY
 ;Store completion time in Scheduling Parameter file
 S SCZ=0
 F X=1:1:10 L +^SD(404.91,1,"AMB"):5 I ($T) S SCZ=1 Q
 S:(SCZ) $P(^SD(404.91,1,"AMB"),"^",7)=%
 L -^SD(404.91,1,"AMB")
 ;Send completion bulletin
 ;Set message text
 S MSGTXT(1)=" "
 S MSGTXT(2)="Updating of all clinics contained in the HOSPITAL LOCATION"
 S MSGTXT(3)="file (#44) to require provider and diagnosis for checkout"
 S MSGTXT(4)="completed on "_SCX
 S MSGTXT(5)=" "
 ;Set bulletin subject
 S XMB(1)="HOSPITAL LOCATION UPDATE COMPLETED"
 ;Deliver bulletin
 S XMB="SCDX AMBCARE TO NPCDB SUMMARY"
 S XMTEXT="MSGTXT("
 D ^XMB
 Q
 ;
PARAM ;ALB/JLU - This entry point will set the Amb Care parameters in the
 ; Scheduling parameter file
 ;
 N DIC,DIE,DA,DR,X,Y,DTOUT,DUOUT,MSGTXT,DELAY
 N PTRPAR,DLAYGO,DINUM,NODE,TASKNUM,QUEUEDT
 D BMES^XPDUTL(">>> Setting parameters contained in SCHEDULING PARAMETER file (#404.91)")
 ;Create/find entry
 S DIC="^SD(404.91,"
 S DIC(0)="LX"
 S DIC("DR")=".001///1"
 S DLAYGO=404.91
 S DINUM=1
 S X=1
 D ^DIC
 S PTRPAR=+Y
 ;Unable to create/find entry - quit
 I (Y<0) D  Q
 .S MSGTXT(1)="   *** Unable to create/find entry in Scheduling Parameter file"
 .S MSGTXT(2)="   *** Unable to store parameters relating to Ambulatory Care"
 .D MES^XPDUTL(.MSGTXT)
 ;Get check point's parameter data.  This value will be in the
 ; format QueueTime-TaskNumber
 S X=$$PARCP^XPDUTL("SCMS01")
 S QUEUEDT=$P(X,"-",1)
 S TASKNUM=$P(X,"-",2)
 ;Store Ambulatory Care parameters - using hard set since there's no
 ; cross references on these fields
 S NODE=$G(^SD(404.91,PTRPAR,"AMB"))
 S $P(NODE,U,1)=+$P(NODE,U,1)
 S $P(NODE,U,2)=2961001
 S $P(NODE,U,3)=2961101
 S DELAY=+$P(NODE,U,4)
 S:('DELAY) DELAY=2
 S $P(NODE,U,4)=DELAY
 S $P(NODE,U,5)=QUEUEDT
 S $P(NODE,U,6)=TASKNUM
 S $P(NODE,U,7)="0000000"
 S ^SD(404.91,1,"AMB")=NODE
 D MES^XPDUTL("    Parameters relating to Ambulatory Care have been stored")
 Q
 ;
MG4BULL ;ALB/JRP - Attach Mail Group that receives OPC generation bulletin
 ; to the Ambulatory Care transmission summary bulletin
 ;
 ;Input  : None
 ;Output : None
 ;Notes  : This is a KIDS complient check point
 ;
 ;Declare variables
 N DIC,DIE,DA,DR,X,Y,DTOUT,DUOUT,OPCMG,BULLNAME,PTRBULL,MSGTXT
 D BMES^XPDUTL(">>> Attaching mail group to Ambulatory Care transmission summary bulletin")
 ;Get name of Mail Group that receives OPC generation bulletin
 S OPCMG=$$OPCMG^SCMSPU1(1)
 I (OPCMG="") D  Q
 .S MSGTXT(1)="    ** MAS PARAMETER file (#43) does not have a value for"
 .S MSGTXT(2)="       the OPC GENERATE MAIL GROUP field (#216)"
 .S MSGTXT(3)="    ** Unable to attach mail group to the SCDX AMBCARE"
 .S MSGTXT(4)="       TO NPCDB SUMMARY bulletin"
 .S MSGTXT(5)="    ** Mail group must be added to bulletin manually"
 .D MES^XPDUTL(.MSGTXT)
 ;Get pointer to Ambulatory Care transmission summary bulletin
 S BULLNAME="SCDX AMBCARE TO NPCDB SUMMARY"
 S PTRBULL=+$O(^XMB(3.6,"B",BULLNAME,0))
 I ('PTRBULL) D  Q
 .S MSGTXT(1)="    ** Unable to find entry for SCDX AMBCARE TO NPCDB"
 .S MSGTXT(2)="       SUMMARY in BULLETIN file (#3.6)"
 .S MSGTXT(3)="    ** Bulletin must be manually entered"
 .D MES^XPDUTL(.MSGTXT)
 ;Attach Mail Group to Ambulatory Care transmission summary bulletin
 S DIC="^XMB(3.6,"_PTRBULL_",2,"
 S DIC(0)="LX"
 S DIC("P")=$P(^DD(3.6,4,0),"^",2)
 S DA(1)=PTRBULL
 S DLAYGO=3.6
 S X=OPCMG
 D ^DIC
 S MSGTXT(1)="    Mail group contained in the OPC GENERATE MAIL GROUP"
 S MSGTXT(2)="    field (#216) of the MAS PARAMETER file (#43) has"
 S MSGTXT(3)="    been attached to the SCDX AMBCARE TO NPCDB SUMMARY bulletin"
 I (Y<0) D
 .K MSGTXT
 .S MSGTXT(1)="    ** Unable to attach mail group to the SCDX AMBCARE"
 .S MSGTXT(2)="       TO NPCDB SUMMARY bulletin"
 .S MSGTXT(3)="    ** Mail group must be added to bulletin manually"
 D MES^XPDUTL(.MSGTXT)
 ;Done
 Q
 ;
SDM ;ALB/JRP - Have an overlap routine with PCMM (SD*5.3*41)
 ;          Make sure that correct version of SDM routine is installed
 ;
 ;Input  : None
 ;Output : None
 ;Notes  : This is a KIDS complient check point
 ;       : Routine SCMSPX1 contains SDM with patch 41 applied to it
 ;         and routine SCMSPX2 contains SDM with patch 41 not applied
 ;         to it
 ;
 ;Declare variables
 N PATCHED,TMP,MSGTXT
 D BMES^XPDUTL(">>> Installing correct version of routine SDM")
 ;Check for PCMM installation
 S PATCHED=$$PATCH^XPDUTL("SD*5.3*41")
 ;PCMM not installed - SDM should come from SCMSPX2
 I ('PATCHED) D
 .S MSGTXT(1)=" "
 .S MSGTXT(2)="    PCMM has NOT been installed.  Will install a version"
 .S MSGTXT(3)="    of routine SDM that DOES NOT have the PCMM changes"
 .S MSGTXT(4)="    applied to it."
 .S MSGTXT(5)=" "
 .S MSGTXT(6)="    MSM sites must copy the SDM routine to all appropriate UCIs"
 .S MSGTXT(7)=" "
 .S MSGTXT(8)="    ********** PLEASE NOTE THE FOLLOWING ***********"
 .S MSGTXT(9)="    *                                              *"
 .S MSGTXT(10)="    * After installing PCMM, call the routine      *"
 .S MSGTXT(11)="    * SCMSP at theline tag SDM (i.e. D SDM^SCMSP)  *"
 .S MSGTXT(12)="    * in order to install a version of routine SDM *"
 .S MSGTXT(13)="    * with the ACRP & PCMM changes applied to it.  *"
 .S MSGTXT(14)="    *                                              *"
 .S MSGTXT(15)="    * MSM sites will then need to copy the updated *"
 .S MSGTXT(16)="    * SDM routine to all appropriate UCIs.         *"
 .S MSGTXT(17)="    *                                              *"
 .S MSGTXT(18)="    ************************************************"
 .D MES^XPDUTL(.MSGTXT)
 .S TMP=$$COPY^SCMSPU2("SCMSPX2","SDM",3)
 ;PCMM installed - SDM should come from SCMSPX1
 I (PATCHED) D
 .S MSGTXT(1)=" "
 .S MSGTXT(2)="    PCMM has been installed.  Will install a version"
 .S MSGTXT(3)="    of routine SDM that has the PCMM changes applied"
 .S MSGTXT(4)="    to it"
 .S MSGTXT(5)=" "
 .S MSGTXT(6)="    MSM sites must copy the SDM routine to all appropriate UCIs"
 .D MES^XPDUTL(.MSGTXT)
 .S TMP=$$COPY^SCMSPU2("SCMSPX1","SDM",3)
 ;Done
 Q
