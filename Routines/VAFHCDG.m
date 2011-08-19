VAFHCDG ;ALB/CM OUTPATIENT DG1 SEGMENT GENERATOR ;3/30/95
 ;;5.3;Registration;**91,151,606**;Jun 06, 1996
 ;
 ;This routine generates the Outpatient DG1 segment
 ;for the Philly project
 ;
ODG1(DFN,EVENT,EVDT,VPTR,PSTR,PNUM) ;
 ;
 ;DFN - Patient File
 ;EVENT - event number from pivot file
 ;EVDT - event date/time FileMan
 ;VPTR - variable pointer
 ;PSTSR - string of fields
 ;(if null - required fields, if "A" - supported
 ;fields, or string of fields seperated by commas")
 ;PNUM - ID # (optional)
 ;
 I '$D(DFN)!('$D(EVENT))!('$D(EVDT))!('$D(VPTR)) Q "-1^Missing parameters, unable to generate DG1 segment"
 I $D(EVENT) I EVENT'="" S NODE=$$PIVX^VAFHPIVT(EVENT,DFN,EVDT)
 I $D(EVENT) I EVENT="" K EVENT
 I '$D(EVENT) S NODE=$$PIVNW^VAFHPIVT(DFN,EVDT,2,VPTR),EVENT=$P(NODE,":")
 I EVENT<1 Q "-1^Bad event number, unable to generate DG1 segment"
 S NODE=$P(NODE,":",2)
 ;
EN1 ;
 N HLD,DG1,TD,CODMET,CODE,LOOP,ICD
 S (CODE,ICD,DG1,ICD,TD,CODMET)=""
 S QUOT=""""""
 I '$D(PNUM) S PNUM=1
 I '$D(PSTR) S PSTR=",2,6,"
 ;I PSTR="A" S PSTR=$$GETF^VAFHUTL("DG1")
 I PSTR="A" S PSTR=",2,3,4,5,6,"
 I PSTR="" S PSTR=",2,6,"
 I +PSTR=-1 Q "-1^Unable to get fields, can't generate DG1 segment"
 ;S LOOP=0
 ;F  S LOOP=LOOP+1,HLD=$P(PSTR,",",LOOP) Q:HLD=""  D
 ;.I HLD=2 S CODMET="I9-ICD9"
 ;.I HLD=3 S CODE=$$COD(NODE) I CODE="" S CODE=QUOT
 ;.I HLD=4 D
 ;..I '$D(CODE) S CODE=$$COD(NODE)
 ;..I +CODE>0 S ICD=$$DES(CODE) I ICD="" S ICD=QUOT
 ;..I +CODE=0 S ICD=QUOT
 ;.I HLD=5 S TD=$$HLDATE^HLFNC(EVDT) I TD="" S TD=QUOT
 ;
 I PSTR[",2," S CODMET="I9-ICD9"
 I PSTR[",3," S CODE=$$COD(NODE) I CODE="" S CODE=QUOT
 I PSTR[",4," DO
 . I '$D(CODE) S CODE=$$COD(NODE)
 . I +CODE>0 S ICD=$$DES(CODE) I ICD="" S ICD=QUOT
 . I +CODE=0 S ICD=QUOT
 I PSTR[",5," S TD=$$HLDATE^HLFNC(EVDT) I TD="" S TD=QUOT
 ;
 S DG1=HLFS_CODE_HLFS_ICD_HLFS_TD
 I DG1?1"^"."^" Q "-1^Unable to populate fields "_PSTR_" - can't generate DG1 segment"
 S DG1="DG1"_HLFS_PNUM_HLFS_CODMET_DG1
 K NODE,QUOT
 Q DG1
 ;
COD(ZNODE) ;
 N OPTR,CDX,PTR,FILE
 ;
 S OPTR=$P(ZNODE,"^",5),PTR=+OPTR,FILE=$P(OPTR,";",2)
 I PTR=""!(FILE'="SCE(") Q QUOT
 ;
 ;try get primary dx first
 S CDX=$$GETPDX(PTR) I CDX DO  Q CDX
 . S CDX=+$P($G(^ICD9(CDX,0)),"^")
 . I 'CDX S CDX=QUOT
 ;
 Q QUOT
 ;
DES(CDX) ;
 ;Get description/name of diagnosis from diagnostic code
 ;
 I CDX="" Q QUOT
 I CDX'?.N1".".N S CDX=CDX_"."
 I '$D(^ICD9("AB",CDX)) D
 .I $D(^ICD9("AB",CDX_" ")) S CDX=CDX_" " Q
 .I $D(^ICD9("AB",CDX_"0")) S CDX=CDX_"0" Q
 .I $D(^ICD9("AB",CDX_"0 ")) S CDX=CDX_"0 " Q
 .I $D(^ICD9("AB",CDX_"00")) S CDX=CDX_"00" Q
 .I $D(^ICD9("AB",CDX_"00 ")) S CDX=CDX_"00 " Q
 I '$D(^ICD9("AB",CDX)) Q QUOT
 S CDX=$O(^ICD9("AB",CDX,""))
 I CDX="" Q QUOT
 I '$D(^ICD9(CDX,0)) Q QUOT
 S CDX=$$ICDDX^ICDCODE(CDX,$G(EVDT))
 S CDX=$S(+CDX<1:QUOT,1:$P(CDX,"^",4))
 Q CDX
 ;
GETPDX(PTR) ;returns first primary diagnois or 0
 N VAENC0,VADX
 S VAENC0=$$SCE^DGSDU(PTR)
 I PTR,+VAENC0,$$DATE^SCDXUTL(+VAENC0)
 E  Q 0
 S CDX=0
 D GETDX^SDOE(PTR,"VADX")
 S VADX=0
 F  S VADX=$O(VADX(VADX)) Q:'VADX  DO  Q:CDX["^P"
 . I $P(VADX(VADX),"^",12)="P" S CDX=+VADX(VADX)_"^P"
 Q +CDX
