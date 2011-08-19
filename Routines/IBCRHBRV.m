IBCRHBRV ;ALB/ARH - RATES: UPLOAD (RC) VERSION FUNCTIONS ; 14-FEB-01
 ;;2.0;INTEGRATED BILLING;**148,169,245,270,285,298,325,334,355,360,365,382,390,408,412,423,427,439,445**;21-MAR-94;Build 11
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; RC functions related to Version.  Update VLIST with new versions.  Update FTYPE if new types of files.
 ;
SELVERS() ; get version to upload from user
 N DIR,DIRUT,DTOUT,DUOUT,IBVLIST,IBQUIT,IBVERS,IBI,IBJ,IBX,X,Y
 ;
 S IBVLIST=$$VERSTR(),IBQUIT=0,IBVERS=0
 ;
 W !!,"Select the version of Reasonable Charges to upload."
 S DIR("?",1)="Enter the code from the list corresponding to the version of Reasonable Charges"
 S DIR("?",2)="to upload.  There are no version 1.3, 2.2, or 2.10 (ten) RC charges." S DIR("?",3)=" "
 S DIR("?",4)="Versions: "_IBVLIST S DIR("?",5)=" " S DIR("?")="Enter version number to upload."
 ;
 F IBI=1:1 D  I +IBQUIT Q
 . W !!,?5,"Select one of the following:",!
 . F IBJ=1:1 S IBX=$P(IBVLIST,",",IBJ) Q:'IBX  W !,?10,IBX,?20,"Reasonable Charges version ",IBX
 . ;
 . W ! S DIR("A")="Enter Version" S DIR(0)="FO^1:5" D ^DIR I $D(DIRUT) S IBQUIT=1
 . I Y>0,(","_IBVLIST_",")[(","_Y_",") S IBVERS=Y,IBQUIT=1 W "  Reasonable Charges version ",IBVERS
 ;
 Q IBVERS
 ;
VERSION() ; return currently loaded version of RC files (1, 1.1, ...)
 N IBX S IBX=$G(^XTMP("IBCR RC SITE","VERSION"))
 Q IBX
 ;
VERSDT(VERS) ; return Effective Date of a version of RC files, either version passed in or currently loaded version
 N IBI,LINE,IBX S IBX="" S VERS=+$G(VERS) I 'VERS S VERS=$$VERSION
 I +VERS F IBI=1:1 S LINE=$P($T(VLIST+IBI),";;",2,99) Q:'LINE  I VERS=+LINE S IBX=$P(LINE,U,3)
 Q IBX
 ;
VERSEDT(VERS) ; return Inactive Date of a version of RC files, either version passed in or currently loaded version
 N IBI,LINE,IBX S IBX="" S VERS=+$G(VERS) I 'VERS S VERS=$$VERSION
 I +VERS F IBI=1:1 S LINE=$P($T(VLIST+IBI),";;",2,99) Q:'LINE  I VERS=+LINE S IBX=$P(LINE,U,4)
 Q IBX
 ;
VERSALL() ; return all RC versions and corresponding effective date 'VERS;EFFDT^VERS;EFFDT^...'
 N IBI,LINE,IBX,IBC S IBX="",IBC=""
 F IBI=1:1 S LINE=$P($T(VLIST+IBI),";;",2,99) Q:'LINE  S IBX=IBX_IBC_+LINE_";"_$P(LINE,U,3),IBC=U
 Q IBX
 ;
VERSEND() ; return all RC versions and corresponding inactive date 'VERS;INACTIVE DT^VERS;INACTIVE DT^...'
 N IBI,LINE,IBX,IBC S IBX="",IBC=""
 F IBI=1:1 S LINE=$P($T(VLIST+IBI),";;",2,99) Q:'LINE  I $P(LINE,U,4) S IBX=IBX_IBC_+LINE_";"_$P(LINE,U,4),IBC=U
 Q IBX
 ;
VERSITE(SITE) ; returns the list of versions loaded for a particular site
 ; *** uses 99201 in the RC PHYSICIAN set to check which versions/dates are loaded
 ; *** so 99201 must have a pro charge in all versions, if not it must be replaced with an item that does
 N IBCS,IBXRF,IBITM,IBVERS,IBCSFN,IBI,IBV,IBX,IBY,IBC
 S IBVERS=$$VERSALL,IBITM=99201
 ;
 I $G(SITE)'="" S IBCS="RC-PHYSICIAN" F  S IBCS=$O(^IBE(363.1,"B",IBCS)) Q:IBCS'["RC-PHYSICIAN"  D
 . S IBV=$L(IBCS," ") I $P(IBCS," ",IBV)'=SITE Q
 . S IBCSFN=$O(^IBE(363.1,"B",IBCS,0)) Q:'IBCSFN  S IBXRF="AIVDTS"_IBCSFN
 . F IBI=1:1 S IBV=$P(IBVERS,U,IBI) Q:'IBV  I $O(^IBA(363.2,IBXRF,IBITM,-$P(IBV,";",2),0)) S IBY(+IBV)=""
 ;
 S (IBX,IBC)="" F IBI=1:1 S IBV=+$P(IBVERS,U,IBI) Q:'IBV  I $D(IBY(IBV)) S IBX=IBX_IBC_IBV S IBC=","
 ;
 Q IBX
 ;
MSGSITE(SITE) ; display a message indicating which versions are loaded for a site
 N IBVERS Q:'$G(SITE)
 S IBVERS=$$VERSITE(SITE)
 I 'IBVERS W !!,?12,"There appear to be no RC charges already loaded for "_SITE_"."
 I +IBVERS W !!,?12,"RC versions "_IBVERS_" appear to be already loaded for "_SITE_"."
 Q
 ;
MSGVERS(SITE) ; check if versions are being loaded in the correct order, should be loaded in date order
 ;   - if loading a version that has already been loaded for the site
 ;   - if loading a version when any future versions have already been loaded for the site
 ;   - if loading a version when the last version has not yet been loaded for the site
 ; *** uses 99201 in the RC PHYSICIAN set to check which versions/dates are loaded
 ; *** so 99201 must have a pro charge in all versions, if not it must be replaced with an item that does
 N IBVERS,IBVDTC,IBVERSIN,IBVERSC,IBVERSO,IBI,VERSTR Q:'$G(SITE)
 ;
 S IBVERS=$$VERSION Q:'IBVERS  S IBVDTC=$$VERSDT,IBVERSIN=","_$$VERSITE(SITE)_",",IBVERSC=","_IBVERS_","
 ;
 ; check if loading a version that has already been loaded
 I IBVERSIN[IBVERSC D
 . W !!,?5,"*** It appears version RC v",IBVERS," has already been loaded for this site ***"
 ;
 ; check if loading a version when any future versions have already been loaded
 S VERSTR=","_$$VERSTR()_",",VERSTR=$P(VERSTR,IBVERSC,2) ; all versions after current version
 F IBI=1:1 S IBVERSO=$P(VERSTR,",",IBI) Q:'IBVERSO  I IBVERSIN[(","_IBVERSO_",")  D
 . W !!,?5,">>> Currently trying to load RC v"_IBVERS_" but RC v"_IBVERSO_" appears to be already",!,?9,"loaded for this site.  The versions should be loaded in date order."
 ;
 ; check if loading a version when the last version has not yet been loaded
 S VERSTR=","_$$VERSTR(1)_",",VERSTR=$P(VERSTR,IBVERSC,2) ; all versions before current version, reverse order
 S IBVERSO=$P(VERSTR,",",1) I +IBVERSO,IBVERSIN'[(","_IBVERSO_",") D
 . W !!,?5,"*** Currently trying to load RC v"_IBVERS_" but RC v"_IBVERSO_" does not appear to be",!,?9,"loaded for this site.  The versions should be loaded in date order."
 . W !!,?5,">>> Continue only if there will never be a need to bill events before ",!,?9,$$FMTE^XLFDT(IBVDTC,2)," for this site.  If RC v"_IBVERSO_" will be needed for this site then",!,?9,"load it first."
 ;
 Q
 ;
VERSTR(RVRS) ; returns string containing list of all Reasonable Charges versions with charges, separated by ","
 ; RVRS - if set, returns the list of versions in reverse order
 N IBI,LINE,IBS,IBR,IBC,IBX  S (IBS,IBR,IBC,IBX)=""
 F IBI=1:1 S LINE=$P($T(VLIST+IBI),";;",2,99) Q:'LINE  S IBS=IBS_IBC_+LINE,IBR=+LINE_IBC_IBR S IBC=","
 S IBX=IBS I +$G(RVRS) S IBX=IBR
 Q IBX
 ;
 ;
 ;
 ;
 ;
 ; File Names:  'IBRCyymmx.TXT'   w/ yymm - year month of version release (except v1)
 ;              'IBRCyymm', file version identifier prefix, from VLIST text version description
 ;              x=A-I/F, single character file identifier, from FTYPE text file description
 ;
FILES(IBFILES,VERS) ; returns array of source Host Files and data for version requested, pass IBFILES by reference
 N IBI,LINE,IBTYPE,IBFILE,IBNAME,IBDESC S VERS=+$G(VERS) I 'VERS S VERS=1
 ;
 ; get requested versions data
 F IBI=1:1 S LINE=$P($T(VLIST+IBI),";;",2,99) Q:'LINE  I VERS=+LINE S IBTYPE=$P(LINE,U,2),IBFILE=$P(LINE,U,5) Q
 ;
 ; get requested versions files
 I +$G(IBTYPE) F IBI=1:1 S LINE=$P($T(@("FT"_IBTYPE)+IBI),";;",2,99) Q:LINE=""  D
 . S IBNAME=IBFILE_$P(LINE,":",1)_".TXT",IBDESC="RC v"_+VERS_" "_$P(LINE,":",2,99)
 . S IBFILES(IBNAME)=IBDESC
 Q
 ;
 ;
 ; versions and their critical data, add new versions here
VLIST ; version ^ file type/version ^ effective date ^ inactive date ^ file prefix
 ;;1.0^1^2990901^3001101^IBRCV
 ;;1.1^1^3001102^3010507^IBRC0011
 ;;1.2^1^3010508^3030428^IBRC0105
 ;;1.4^1^3030429^3031218^IBRC0304
 ;;2.0^2^3031219^3040414^IBRC0312
 ;;2.1^2^3040415^3041231^IBRC0404
 ;;2.3^2^3050101^3050410^IBRC0501
 ;;2.4^2^3050411^3050930^IBRC0504
 ;;2.5^2^3051001^3051231^IBRC0510
 ;;2.6^2^3060101^3060824^IBRC0601
 ;;2.7^2^3060825^3060930^IBRC0608
 ;;2.8^2^3061001^3061231^IBRC0610
 ;;2.9^2^3070101^3070930^IBRC0701
 ;;2.11^2^3071001^3071231^IBRC0710
 ;;3.1^2^3080101^3080930^IBRC0801
 ;;3.2^2^3081001^3081231^IBRC0810
 ;;3.3^2^3090101^3090930^IBRC0901
 ;;3.4^2^3091001^3091231^IBRC0910
 ;;3.5^2^3100101^3100930^IBRC1001
 ;;3.6^2^3101001^3101231^IBRC1010
 ;;3.7^2^3110101^^IBRC1101
 ;;
 ; 
 ; 
 ; 
 ; 
 ; 
 ; 
 ; 
FTYPE ; file type/versions and relevant data
 ; file identifer is used with XTMP subscript 'IBCR RC ' and routine label to parse file
 ; file identifier : file name/description ^ file identifier ^ number of columns (for v2+)
 ;
FT1 ; Reasonable Charge File Type 1 files
 ;;A:Inpatient Facility Charges^A
 ;;B:Inpatient Facility Area Factors^B
 ;;C:Outpatient Facility Charges^C
 ;;D:Outpatient Facility Area Factors^D
 ;;E:Physician Charges E^E
 ;;F:Physician Charges F^F
 ;;G:Physician Charges G^G
 ;;H:Physician Area Factors^H
 ;;I:Physician Unit Area Factors^I
 ;;
 ;
FT2 ; Reasonable Charges File Type 2 files
 ;;A:Inpatient Facility Charges^A^10
 ;;B:Outpatient Facility Charges^B^14
 ;;C:Professional Charges^C^23
 ;;D:Service Category Codes^D^4
 ;;E:Area Factors^E^41
 ;;F:VA Sites and Zip Codes^F^4
 ;;
