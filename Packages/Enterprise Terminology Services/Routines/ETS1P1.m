ETS1P1 ;O-OIFO/FM23 - ETS*1.0*1 Post-Install ;04/19/2017
 ;;1.0;Enterprise Terminology Service;**1**;Mar 20, 2017;Build 7
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
PRE ;
 ; Check if Scientific notation for lowercase "e" is enabled.  If so, disable it.
 N SN
 K ^TMP("ETSSN",$J)
 S SN=##class(%SYSTEM.Process).ScientificNotation()
 ; Quit if already disabled.
 I SN=0 Q
 ; If not, disable it
 S ^TMP("ETSSN",$J)=SN
 D ##class(%SYSTEM.Process).ScientificNotation(0)
 Q
 ;
PST ; Entry Point for post-install
 D MES^XPDUTL("  Starting post-install for ETS*1.0*1")
 ;
 ; If Scientific notation for lowercase "e" was disabled, re-enable it
 I $G(^TMP("ETSSN",$J))=1 D ##class(%SYSTEM.Process).ScientificNotation(1)
 ;
 ; Update LOINC AXIS CODES
 D AXIS
 ;
EX ; exit point
 ;
 D MES^XPDUTL("  Finished post-install of ETS*1.0*1")
 Q
 ;
AXIS ;
 ; Update Name field of AXIS codes
 N CNT,LINE,DATA,NAME,TYPE,FDA,IEN,MESS,N,X,FILENO
 D MES^XPDUTL("    - Updating LOINC AXIS CODES")
 S CNT=0
 F LINE=1:1 S DATA=$P($T(AXISNMS+LINE),";;",2,99) Q:DATA=""  D
 . S NAME=$P(DATA,";",1),TYPE=$P(DATA,";",2)
 . K FDA,IEN,MESS
 . S N="" F  S N=$O(^ETSLNC(129.12,"B",NAME,N)) Q:'N  D
 .. S X=$G(^ETSLNC(129.12,N,0))
 .. I $P(X,"^",7)=TYPE S IEN=N_","
 . I '$D(IEN) D MES^XPDUTL("      - No IEN found for name "_NAME_" and type "_TYPE) Q
 . S FILENO=129.12
 . S FDA(FILENO,IEN,.01)=NAME_"!"_TYPE
 . D FILE^DIE("","FDA","MESS")
 . I '$D(MESS) S CNT=CNT+1
 D MES^XPDUTL("      - "_CNT_" entries updated")
 D MES^XPDUTL("    - Done with LOINC AXIS CODES")
 D MES^XPDUTL(" ")
 Q
 ;
AXISNMS ;
 ;;1ST SPECIMEN;CHALLENGE
 ;;1ST SPECIMEN;ADJUSTMENT
 ;;ASTERISK;TIME ASPECT
 ;;ASTERISK;SYSTEM
 ;;ASTERISK;SCALE TYPE
 ;;CLOCK TIME;PROPERTY
 ;;CLOCK TIME;UNITS
 ;;DASH;PROPERTY
 ;;DASH;SCALE TYPE
 ;;DASH;TIME ASPECT
 ;;NOT SPECIFIED;TIME ASPECT
 ;;NOT SPECIFIED;SYSTEM
 ;;PROCEDURE;TIME ASPECT
 ;;PROCEDURE;SYSTEM
 ;;SCORE;UNITS
 ;;SCORE;PROPERTY
 ;;
