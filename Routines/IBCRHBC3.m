IBCRHBC3 ;ALB/ARH - RATES: UPLOAD HOST FILES (CMAC 2005+) ; 10-MAY-2005
 ;;2.0;INTEGRATED BILLING;**307,329**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; ROUTINE SPECIFIC FOR FORMAT OF YEAR 2005+ CMAC FILES
 ;
CMAC(IBPATH,IBFILE,IBNAME,IBMODP,IBMODT) ; upload CMAC file from a VMS file into ^XTMP
 N X,Y,IBI,IBXRF,IBDONE,IBXRF1,IBXRF2,IBFLINE,IBINACT,IBMOD,IBCHG
 N IBLOC,IBCPT,IBNFP,IBFP,IBNFNP,IBFNP,IBEFDT,IBTRDT,IBPPC,IBPTC,IBNPPC,IBNPTC
 ;
 D SETUP(IBFILE,IBNAME)
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
 . W !!,"**** Error while reading file: line not expected format (98 numeric characters):"
 . W !!,"Line Length=",$L(IBFLINE)," characters" W:IBFLINE="" ?40,"Line read is null"
 . W !,"LINE='",IBFLINE,"'",!!,"Upload Aborted!"
 . S IBX=1 H 7 U IO
 I IBI=1,IBFLINE="" U IO(0) W !!,"First line of file has no data, can not continue!" S IBX=1 H 7 U IO
 Q IBX
 ;
LNFORM(LINE) ; check an individual line of the file for proper format (length=98 characters)
 N IBX S IBX=0,LINE=$G(LINE) I (LINE?98N)!(LINE?3N5AN90N) S IBX=1
 Q IBX
 ;
PARSE ; process a single line from a CMAC file: parse out into individual fields and store the line in XTMP
 ;
 S IBLOC=$E(IBFLINE,1,3) ; locality
 S IBCPT=$E(IBFLINE,4,8) ; CPT procedure
 S IBNFP=$E(IBFLINE,9,16) ;   category 2 Non-Facility Physician charge
 S IBFP=$E(IBFLINE,17,24) ;   category 1 Facility Physician charge
 S IBNFNP=$E(IBFLINE,25,32) ; category 4 Non-Facility Non-Physician charge
 S IBFNP=$E(IBFLINE,33,40) ;  category 3 Facility Non-Physician charge
 S IBEFDT=$E(IBFLINE,41,48) ; effective date
 S IBTRDT=$E(IBFLINE,57,64) ; termination date
 S IBPPC=$E(IBFLINE,65,72) ;  Physician professional component
 S IBPTC=$E(IBFLINE,73,80) ;  Physician technical component
 S IBNPPC=$E(IBFLINE,81,88) ; Non-Physician professional component
 S IBNPTC=$E(IBFLINE,89,96) ; Non-Physician technical component
 Q
 ;
STORE ;
 S IBXRF1=IBXRF_"  "_IBLOC
 ;
 S IBMOD="",IBEFDT=$$DATE(IBEFDT),IBINACT="" I IBTRDT'=99999999,+IBTRDT S IBINACT=$$DATE(IBTRDT)
 ;
 I +IBFP S IBCHG=$$CGF(IBFP),IBMOD="" S IBXRF2="FAC/PHYS CAT 1" D SET
 I +IBFNP S IBCHG=$$CGF(IBFNP),IBMOD="" S IBXRF2="FAC/NONPHYS CAT 3" D SET
 ;
 I +IBNFP S IBCHG=$$CGF(IBNFP),IBMOD="" S IBXRF2="NONFAC/PHYS CAT 2" D SET
 I +IBNFNP S IBCHG=$$CGF(IBNFNP),IBMOD="" S IBXRF2="NONFAC/NONPHYS CAT 4" D SET
 ;
 I +IBMODP,+IBPPC S IBCHG=$$CGF(IBPPC),IBMOD=IBMODP S IBXRF2="FAC/PHYS PC" D SET S IBXRF2="NON"_IBXRF2 D SET
 I +IBMODT,+IBPTC S IBCHG=$$CGF(IBPTC),IBMOD=IBMODT S IBXRF2="FAC/PHYS TC" D SET S IBXRF2="NON"_IBXRF2 D SET
 ;
 I +IBMODP,+IBNPPC S IBCHG=$$CGF(IBNPPC),IBMOD=IBMODP S IBXRF2="FAC/NONPHYS PC" D SET S IBXRF2="NON"_IBXRF2 D SET
 I +IBMODT,+IBNPTC S IBCHG=$$CGF(IBNPTC),IBMOD=IBMODT S IBXRF2="FAC/NONPHYS TC" D SET S IBXRF2="NON"_IBXRF2 D SET
 ;
 Q
 ;
CGF(AMT) ; return charge string from file line in dollar format
 Q +($E(AMT,1,6)_"."_$E(AMT,7,8))
 ;
SET ;
 N IBX S IBX=$G(^XTMP(IBXRF1,0)) I IBX="" D SETHDR
 S $P(^XTMP(IBXRF1,0),U,4)=+$P(IBX,U,4)+1
 S $P(^XTMP(IBXRF1,IBXRF2),U,1)=+$G(^XTMP(IBXRF1,IBXRF2))+1
 S ^XTMP(IBXRF1,IBXRF2,IBI)=IBCPT_U_IBEFDT_U_IBINACT_U_+IBCHG_U_IBMOD
 Q
 ;
SETHDR ;
 N IBX S IBX="IB upload of Host file "_IBFILE_", on "_$$HTE^XLFDT($H,2)_" by "_$P($G(^VA(200,+$G(DUZ),0)),U,1)
 S ^XTMP(IBXRF1,0)=$$FMADD^XLFDT(DT,2)_U_DT_U_IBX
 ;
 S ^XTMP(IBXRF1,IBXRF2)=0_U_2_U_$G(IBCS)
 Q
 ;
 ;
DATE(DATE) ; return yymmdd in FM format
 N IBX S IBX="" I $G(DATE)?8N S IBX=$S($E(DATE,1,2)<20:"2",1:"3")_$E(DATE,3,8)
 Q IBX
 ;
 ;
LNDT(LINE) ; return the date of an individual line, in FM format
 N IBX S IBX=$E($G(LINE),41,48) S IBX=$$DATE(IBX)
 Q IBX
 ;
 ;
 ;
SETUP(IBFILE,IBNAME) ; set up Charge Sets, Billing Regions, Rate Schedule links for new charges
 ; if new region entered, asks user for divisions
 N IBLOC,IBXRF1,IBXRF2,IBEVENT,IBCT,IBBS,IBRV,IBRG,IBCS
 ;
 S IBLOC=$P($P($G(IBFILE),"CMAC",2),".",1),IBXRF1=$G(IBNAME)_IBFILE_"  "_IBLOC
 S IBEVENT="PROCEDURE",IBCT="PROF",IBBS="OUTPATIENT VISIT",IBRV=510
 ;
 ;
 ; Find/Create Billing Region
 S IBRG=$$RG^IBCRHU2("CMAC "_IBLOC,,IBLOC)
 ;
 ;
 ; Category 1 Facility Physician Charges
 S IBCS=$$CS^IBCRHU2("CMAC "_IBLOC_" FAC/PHYS","CMAC",IBEVENT,$P(IBRG,U,2),IBCT,IBRV,IBBS)
 D RSBR^IBCRHU2(IBCS,1,$G(IBGLBEFF))
 F IBXRF2="FAC/PHYS CAT 1","FAC/PHYS PC","FAC/PHYS TC" D SETHDR
 ;
 ;
 ; Category 3 Facility Non-Physician Charges
 S IBCS=$$CS^IBCRHU2("CMAC "_IBLOC_" FAC/NONPHYS","CMAC",IBEVENT,$P(IBRG,U,2),IBCT,IBRV,IBBS)
 D RSBR^IBCRHU2(IBCS,0,$G(IBGLBEFF))
 F IBXRF2="FAC/NONPHYS CAT 3","FAC/NONPHYS PC","FAC/NONPHYS TC" D SETHDR
 ;
 ;
 ; Category 2 Non-Facility Physician Charges
 S IBCS=$$CS^IBCRHU2("CMAC "_IBLOC_" NONFAC/PHYS","CMAC",IBEVENT,$P(IBRG,U,2),IBCT,IBRV,IBBS)
 D RSBR^IBCRHU2(IBCS,0,$G(IBGLBEFF))
 F IBXRF2="NONFAC/PHYS CAT 2","NONFAC/PHYS PC","NONFAC/PHYS TC" D SETHDR
 ;
 ;
 ; Category 4 Non-Facility Non-Physician Charges
 S IBCS=$$CS^IBCRHU2("CMAC "_IBLOC_" NONFAC/NONPHYS","CMAC",IBEVENT,$P(IBRG,U,2),IBCT,IBRV,IBBS)
 D RSBR^IBCRHU2(IBCS,0,$G(IBGLBEFF))
 F IBXRF2="NONFAC/NONPHYS CAT 4","NONFAC/NONPHYS PC","NONFAC/NONPHYS TC" D SETHDR
 ;
 ;
 ; get divisions added to new Billing Region
 I +$P(IBRG,U,3) D GETDIV^IBCRHU2(+IBRG)
 Q
