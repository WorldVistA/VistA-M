IVM279P ;ALB/BRM - IVM*2*79 PRE-INSTALL ; 7/30/03 10:17am
 ;;2.0;INCOME VERIFICATION MATCH;**79**; 21-OCT-94
 ;
 Q
PRE ; pre-install entry point
 ; add 3 new entries to the 301.92 file
 N FDA,DATA,ERR
 S DATA=""
 D BMES^XPDUTL("  >> Adding entries to IVM DEMOGRAPHIC UPLOAD FIELDS (#301.92) file")
 D ADDRDT(.DATA),UPDATE(.DATA)
 D ADDRSRC(.DATA),UPDATE(.DATA)
 D ADDRSIT(.DATA),UPDATE(.DATA)
 D MES^XPDUTL("")
 Q
 ;
ADDRDT(DATA) ; setup fda array for Address Change Dt/Tm entry
 S DATA(.01)="ADDRESS CHANGE DT/TM"
 S DATA(.02)="RF171",DATA(.05)=.118,DATA(.04)=2
 S (DATA(.03),DATA(.06),DATA(.07),DATA(.08))=1
 S (DATA(10),DATA(20))="S DR=.118 D LOOK^IVMPREC9"
 Q
 ;
ADDRSRC(DATA) ; setup fda array for Address Change Source entry
 S DATA(.01)="ADDRESS CHANGE SOURCE"
 S DATA(.02)="RF162",DATA(.05)=.119,DATA(.04)=2
 S (DATA(.03),DATA(.06),DATA(.07),DATA(.08))=1
 S (DATA(10),DATA(20))="S DR=.119 D LOOK^IVMPREC9"
 Q
 ;
ADDRSIT(DATA) ; setup fda array for Address Change Dt/Tm entry
 S DATA(.01)="ADDRESS CHANGE SITE"
 S DATA(.02)="RF161",DATA(.05)=.12,DATA(.04)=2
 S (DATA(.03),DATA(.06),DATA(.07),DATA(.08))=1
 S (DATA(10),DATA(20))="S DR=.12 D LOOK^IVMPREC9"
 Q
 ;
UPDATE(DATA) ;
 I $$FIND1^DIC(301.92,"","X",$G(DATA(.01))) D BMES^XPDUTL("      *** "_$G(DATA(.01))_" entry already exists!") Q
 S FLDNUM="" F  S FLDNUM=$O(DATA(FLDNUM)) Q:'FLDNUM  S FDA(301.92,"+1,",FLDNUM)=$G(DATA(FLDNUM))
 D UPDATE^DIE("","FDA","","ERR")
 I $D(ERR) D BMES^XPDUTL("   >>> ERROR! "_$G(DATA(.01))_" not added to file #301.92!"),MES^XPDUTL(ERR("DIERR",1)_": "_ERR("DIERR",1,"TEXT",1)) Q
 D BMES^XPDUTL("      "_$G(DATA(.01))_" successfully added.")
 K DATA
 Q
 ;
POST ; post-install process to task one-time clean-up
 ;
 N IVMTSK,IVMDT
 D BMES^XPDUTL("  >> Tasking IVM Clean-up job to run in 30 days")
 D BMES^XPDUTL("  WARNING: This clean-up will delete DEMOGRAPHIC UPLOAD DATA")
 D MES^XPDUTL("           from the IVM PATIENT (#301.5) file when it runs.")
 D BMES^XPDUTL("  Please notify the appropriate personnel to take action on any")
 D MES^XPDUTL("  outstanding demographics uploaded data from HEC, if your site")
 D MES^XPDUTL("  processes IVM DEMOGRAPHICS UPLOADs on a regular basis.")
 D DT^DILF("X","T+30",.IVMDT) S:IVMDT IVMDT=IVMDT_.180000
 S IVMTSK=$$QUETSK($G(IVMDT))
 I 'IVMTSK D BMES^XPDUTL("  ***ERROR: IVM DEMOGRAPHICS CLEAN-UP could not be tasked."),BMES^XPDUTL("    >>> Please contact NVS for assistance <<<") Q
 D BMES^XPDUTL("  Task #"_IVMTSK_" has been queued to run on "_$$FMTE^XLFDT(IVMDT)_".")
 D MES^XPDUTL("  This task can be rescheduled for an earlier date if desired.")
 Q
QUETSK(ZTDTH) ;
 N ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTSK,ZUSR,POP,X,ERR
 Q:'$G(ZTDTH) 0
 S ZTRTN="EN^IVMLDEMC()",ZTDESC="IVM DEMOGRAPHICS CLEAN-UP",ZTIO=""
 D ^%ZTLOAD
 Q +$G(ZTSK)
