IBCRHBC1 ;ALB/ARH - RATES: UPLOAD HOST FILES (CMAC <2000) ; 14-FEB-2000
 ;;2.0;INTEGRATED BILLING;**124**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; ROUTINE SPECIFIC FOR FORMAT OF PRE-2000 CMAC FILES
 ;
CMAC(IBPATH,IBFILE,IBNAME,IBMODP,IBMODT) ; upload CMAC file from a VMS file into ^XTMP
 N X,Y,IBI,IBXRF,IBLOC,IBDONE,IBXRF1,IBXRF2,IBFLINE,IBINACT,IBMOD,IBCHG
 N IBCPT,IBCL1,IBCL2,IBCL34,IBEFDT,IBTRDT,IBCL1P,IBCL1T,IBCL4P,IBCL4T
 ;
 S IBXRF=IBNAME_IBFILE,IBLOC="",IBDONE=""
 ;
 D OPEN^%ZISH("CMAC UPLOAD",IBPATH,IBFILE,"R") I POP W !!,"**** Unable to open ",IBPATH,IBFILE,! G CMACQ
 ;
 U IO(0) W !!,"Loading ",IBFILE," into ^XTMP "
 ;
 S IBI=0 F  S IBI=IBI+1 U IO R IBFLINE:5 Q:$$ENDF  D PARSE,STORE I '(IBI#100) U IO(0) W "."
 ;
 D CLOSE^%ZISH("CMAC UPLOAD")
 ;
 S IBDONE=(IBI-1)_U_IBXRF
 ;
CMACQ Q IBDONE
 ;
ENDF() N IBX S IBX=1 I $T,IBFLINE'="" S IBX=0
 I $$STATUS^%ZISH S IBX=1
 I 'IBX,'$$LNFORM(IBFLINE) D
 . U IO(0)
 . W !!,"**** Error while reading file: line not expected format (85 numeric characters):"
 . W !!,"Line Length=",$L(IBFLINE)," characters" W:IBFLINE="" ?40,"Line read is null"
 . W !,"LINE='",IBFLINE,"'",!!,"Upload Aborted!"
 . S IBX=1 H 7 U IO
 I IBI=1,IBFLINE="" U IO(0) W !!,"First line of file has no data, can not continue!" S IBX=1 H 7 U IO
 Q IBX
 ;
LNFORM(LINE) ; check an individual line of the file for proper format
 N IBX S IBX=0,LINE=$G(LINE) I (LINE?85N)!(LINE?3N1A81N) S IBX=1
 Q IBX
 ;
PARSE ; process a single lin from a CMAC file: parse out into individual fields and store the line in XTMP
 ;
 S IBLOC=$E(IBFLINE,1,3) ; locality
 S IBCPT=$E(IBFLINE,4,8) ; CPT procedure
 S IBCL1=$E(IBFLINE,9,16) ; class 1 charge
 S IBCL2=$E(IBFLINE,17,24) ; class 2 charge
 S IBCL34=$E(IBFLINE,25,32) ; class 3&4 charge
 S IBEFDT=$E(IBFLINE,36,41) ; effective date
 S IBTRDT=$E(IBFLINE,48,53) ; termination date
 S IBCL1P=$E(IBFLINE,54,61) ; class 1 professional component
 S IBCL1T=$E(IBFLINE,62,69) ; class 1 technical component
 S IBCL4P=$E(IBFLINE,70,77) ; class 4 professional component
 S IBCL4T=$E(IBFLINE,78,85) ; class 4 technical component
 Q
 ;
STORE ;
 S IBXRF1=IBXRF_"  "_IBLOC
 ;
 S IBMOD="",IBEFDT=$$DATE(IBEFDT),IBINACT="" I IBTRDT'=999999,+IBTRDT S IBINACT=$$DATE(IBTRDT)
 ;
 I +IBCL1 S IBXRF2="CLASS 1",IBCHG=$E(IBCL1,1,6)_"."_$E(IBCL1,7,8) D SET ; class 1 charge
 I +IBCL2 S IBXRF2="CLASS 2",IBCHG=$E(IBCL2,1,6)_"."_$E(IBCL2,7,8) D SET ; class 2 charge
 I +IBCL34 S IBXRF2="CLASS 3&4",IBCHG=$E(IBCL34,1,6)_"."_$E(IBCL34,7,8) D SET ; class 3&4 charge
 ;
 I +IBMODP,+IBCL1P S IBXRF2="CLASS 1 PC",IBCHG=$E(IBCL1P,1,6)_"."_$E(IBCL1P,7,8),IBMOD=IBMODP D SET
 I +IBMODT,+IBCL1T S IBXRF2="CLASS 1 TC",IBCHG=$E(IBCL1T,1,6)_"."_$E(IBCL1T,7,8),IBMOD=IBMODT D SET
 ;
 I +IBMODP,+IBCL4P S IBXRF2="CLASS 4 PC",IBCHG=$E(IBCL4P,1,6)_"."_$E(IBCL4P,7,8),IBMOD=IBMODP D SET
 I +IBMODT,+IBCL4T S IBXRF2="CLASS 4 TC",IBCHG=$E(IBCL4T,1,6)_"."_$E(IBCL4T,7,8),IBMOD=IBMODT D SET
 ;
 Q
 ;
SET ;
 N IBX S IBX=$G(^XTMP(IBXRF1,0)) I IBX="" D SETHDR
 S $P(^XTMP(IBXRF1,0),U,4)=+$P(IBX,U,4)+1
 S ^XTMP(IBXRF1,IBXRF2)=(+$G(^XTMP(IBXRF1,IBXRF2))+1)_U_2
 S ^XTMP(IBXRF1,IBXRF2,IBI)=IBCPT_U_IBEFDT_U_IBINACT_U_+IBCHG_U_IBMOD
 Q
 ;
SETHDR ;
 N IBX S IBX="IB upload of Host file "_IBFILE_", on "_$$HTE^XLFDT($H,2)_" by "_$P($G(^VA(200,+$G(DUZ),0)),U,1)
 S ^XTMP(IBXRF1,0)=$$FMADD^XLFDT(DT,2)_U_DT_U_IBX
 Q
 ;
 ;
DATE(DATE) ; return yymmdd in FM format
 N IBX S IBX="" I $G(DATE)?6N S IBX=$S($E(DATE,1,2)>70:"2",1:"3")_DATE
 Q IBX
 ;
 ;
LNDT(LINE) ; return the date of an individual line, in FM format
 N IBX S IBX=$E($G(LINE),36,41) S IBX=$$DATE(IBX)
 Q IBX
