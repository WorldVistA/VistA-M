RORUTL16 ;HCIOFO/SG - PHARMACY DATA SEARCH (UTILITIES) ; 10/6/05 9:34am
 ;;1.5;CLINICAL CASE REGISTRIES;**32**;Feb 17, 2006;Build 20
 ;
 ; This routine uses the following IAs:
 ;
 ; #4533         AND^PSS50, VAC^PSS50 (supported)
 ; #4543         IEN^PSN50P65 (supported)
 ;
 Q
 ;
 ;***** LOADS THE LIST OF REGISTRY SPECIFIC DRUGS
 ;
 ; ROR8DST       Closed root of the destination buffer
 ;
 ; REGIEN        Registry IEN
 ;
 ; [FLAGS]       Flags to control processing:
 ;                 A  Do not kill the destination array before
 ;                    loading the drugs (Add the drugs)
 ;                 C  Include VA drug classes from the file #798.6
 ;                 D  Include local (dispensed) drugs from the LOCAL
 ;                    DRUG NAME multiple of the file #798.1
 ;                 G  Include generic drugs from the file #799.51
 ;                 R  Reduce everything to local (dispensed) drugs
 ;
 ;               If this parameter has no value ($G(FLAGS)="") then
 ;               the default set of flags is used: "DGR".
 ;
 ; [GROUPID]     Optional identifier of the drug group. By default
 ;               ($G(GROUPID)=""), 0 is used.
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
 ; The list of drugs is returned as follow:
 ;
 ; @ROR8DST@(
 ;   DrugIEN,
 ;     GroupID)          ""
 ;   "C",
 ;     VAClassIEN,
 ;       GroupID)        ""
 ;   "G",
 ;     GenericDrugIEN,
 ;       GroupID)        ""
 ;
 ; DrugIEN is an internal entry number of the local drug record
 ; in the DRUG file (#50).
 ;
 ; Nodes "C" and/or "G" are created only if the R flag is not used.
 ; Otherwise, VA drug classes and generic drugs are reduced to the
 ; local (dispensed) drugs.
 ;
DRUGLIST(ROR8DST,REGIEN,FLAGS,GROUPID) ;
 N DRUGIEN,IEN,NDFP,RC,REDUCE,ROOT,RORMSG,VACLIEN
 S FLAGS=$S($G(FLAGS)'="":FLAGS,1:"DGR")
 S GROUPID=$S($G(GROUPID)'="":GROUPID,1:0)
 S REDUCE=(FLAGS["R")  K:FLAGS'["A" @ROR8DST
 ;
 ;--- Drug classes
 D:FLAGS["C"
 . S IEN=0
 . F  S IEN=$O(^ROR(798.6,"AC",REGIEN,IEN))  Q:IEN'>0  D
 . . D RXADDVCL(ROR8DST,+$G(^ROR(798.6,IEN,0)),REDUCE,GROUPID)
 ;
 ;--- Local drug names
 D:FLAGS["D"
 . S ROOT=$$ROOT^DILFD(798.129,","_REGIEN_",",1)
 . S IEN=0
 . F  S IEN=$O(@ROOT@(IEN))  Q:IEN'>0  D
 . . S DRUGIEN=+$P($G(@ROOT@(IEN,0)),U)
 . . S:DRUGIEN>0 @ROR8DST@(DRUGIEN,GROUPID)=""
 ;
 ;--- Generic drugs
 D:FLAGS["G"
 . N RGS  S RGS=REGIEN_"#",DRUGIEN=0
 . F  S DRUGIEN=$O(^ROR(799.51,"ARDG",RGS,DRUGIEN))  Q:DRUGIEN'>0  D
 . . D RXADDGEN(ROR8DST,DRUGIEN,REDUCE,GROUPID)
 Q 0
 ;
 ;***** LOADS PHARMACY ORDER DATA
 ;
 ; .ROR8DST      Reference to the ROR8DST parameter
 ;               passed into the callback function.
 ;
 ; ORDFLGS       Flags describing the original order
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;        1  Skip this refill
 ;
ORDER(ROR8DST,ORDFLGS) ;
 N DATE,FILLTYPE
 D:ORDFLGS["I"
 . S DATE=$P(RORRXE(0),U,5),FILLTYPE="I"
 D:ORDFLGS["O"
 . S DATE=$P(RORRXE("RXN",0),U,6)
 . S FILLTYPE=$P(RORRXE("RXN",0),U,3)
 Q
 ;
 ;***** ADDS THE GENERIC DRUG TO THE LIST OF DRUGS
 ;
 ; ROR8DST       Closed root of the destination buffer
 ;
 ; GENIEN        IEN of a generic drug
 ;
 ; [REDUCE]      Reduce the class to a list of local drugs
 ;
 ; [GROUPID]     Drug group ID
 ;
RXADDGEN(ROR8DST,GENIEN,REDUCE,GROUPID) ;
 Q:GENIEN'>0
 S GROUPID=$S($G(GROUPID)'="":GROUPID,1:0)
 I '$G(REDUCE)  S @ROR8DST@("G",GENIEN,GROUPID)=""  Q
 N DRUGIEN,RORTMP,RORTS
 S RORTMP=$$ALLOC^RORTMP(.RORTS)
 D AND^PSS50(GENIEN,,,RORTS)
 S DRUGIEN=0
 F  S DRUGIEN=$O(@RORTMP@(DRUGIEN))  Q:DRUGIEN'>0  D
 . S @ROR8DST@(DRUGIEN,GROUPID)=""
 D XDRG^RORUTL22(GENIEN,GROUPID)
 D FREE^RORTMP(RORTMP)
 Q
 ;
 ;***** ADDS THE VA DRUG CLASS TO THE LIST OF DRUGS
 ;
 ; ROR8DST       Closed root of the destination buffer
 ;
 ; VACL          Either IEN or code of a VA drug class
 ;
 ; [REDUCE]      Reduce the class to a list of local drugs
 ;
 ; [GROUPID]     Drug group ID
 ;
 ; [FLAGS]       Flags to control processing:
 ;                 E  Always treat content of the VACL parameter as
 ;                    a code of the VA Drug Class (instead of IEN)
 ;
RXADDVCL(ROR8DST,VACL,REDUCE,GROUPID,FLAGS) ;
 N DRUGIEN,RORMSG,RORTMP,RORTS,TMP,VACLIEN
 S RORTMP=$$ALLOC^RORTMP(.RORTS)
 D
 . S VACLIEN=+VACL
 . I (VACLIEN'=VACL)!($G(FLAGS)["E")  D
 . . D IEN^PSN50P65(,VACL,RORTS)
 . . S TMP=+$G(@RORTMP@(0))
 . . S VACLIEN=$S(TMP=1:+$O(@RORTMP@(0)),1:0)
 . Q:VACLIEN'>0
 . ;---
 . S GROUPID=$S($G(GROUPID)'="":GROUPID,1:0)
 . I '$G(REDUCE)  S @ROR8DST@("C",VACLIEN,GROUPID)=""  Q
 . D VAC^PSS50(VACLIEN,,,RORTS)
 . S DRUGIEN=0
 . F  S DRUGIEN=$O(@RORTMP@(DRUGIEN))  Q:DRUGIEN'>0  D
 . . S @ROR8DST@(DRUGIEN,GROUPID)=""
 ;
 D FREE^RORTMP(RORTMP)
 Q
