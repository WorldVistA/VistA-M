HMPXGORD ; ASMR/hrubovcak - ORDER file (#100) data retrieval ;Nov 03, 2015 18:23:03
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**;Sep 01, 2011;Build 63
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
TOP(HMPRSLT,HMPORIEN,HMPFLDS,HMPFLG) ; return top-level fields
 ; HMPRSLT - result array, closed reference, required
 ; HMPORIEN - IEN of NEW PERSON, required
 ; HMPFLDS - field list, required, FileMan convention 
 ; HMPFLG - data flag, optional, FileMan convention
 ;
 Q:'$L($G(HMPRSLT))
 ;
 K @HMPRSLT  ; clear all results
 ; error data is found in -1 subscript
 I '($G(HMPORIEN)>0) S @HMPRSLT@(-1,$T(+0))="ORDER IEN required" Q
 I $G(HMPFLDS)="" S @HMPRSLT@(-1,$T(+0))="ORDER fields required" Q
 I '$L($G(HMPFLG)) N HMPFLG S HMPFLG="EIN"  ; default is external and internal, skip nulls
 N DA,DIC,DIQ,DR,FLAGS  ; FileMan variables
 S DIC=100,DR=HMPFLDS,DA=HMPORIEN,DIQ=HMPRSLT,DIQ(0)=HMPFLG,FLAGS=HMPFLG
 D EN^DIQ1
 Q
 ;
DIALOG(HMPORIEN) ; function, return (#2) DIALOG [5V] for ORDER
 Q $P($G(^OR(100,+$G(HMPORIEN),0)),"^",5)
 ;
ORDTOP(HMPORDFL,HMPORDIEN,HMPORDND) ; function, return top-level node from a file in ^ORD (file list below)
 ;
 I '($G(HMPORDFL)>0)!'($G(HMPORDIEN)>0)!'$L($G(HMPORDND)) Q ""  ; all required
 ;
 Q $G(^ORD(HMPORDFL,HMPORDIEN,HMPORDND))  ; returns internal format
 ;
 ;
 ; files in the ^ORD global:
 ;
 ;ORDER STATUS (#100.01)
 ;NATURE OF ORDER (#100.02)
 ;ORDER REASON (#100.03)
 ;ORDER CHECK INSTANCES (#100.05)
 ;OE/RR PRINT FIELDS (#100.22)
 ;OE/RR PRINT FORMATS (#100.23)
 ;OE/RR RELEASE EVENTS (#100.5)
 ;OE/RR AUTO-DC RULES (#100.6)
 ;OE/RR EPCS PARAMETERS (#100.7)
 ;ORDER CHECKS (#100.8)
 ;OE/RR NOTIFICATIONS (#100.9)
 ;DISPLAY GROUP (#100.98)
 ;ORDER PARAMETERS (#100.99)
 ;PROTOCOL (#101)
 ;OR CPRS TABS (#101.13)
 ;OE/RR COM OBJECTS (#101.15)
 ;OE/RR REPORT (#101.24)
 ;ORDER EXECUTE CODES (#101.3)
 ;ORDER DIALOG (#101.41)
 ;ORDER URGENCY (#101.42)
 ;ORDERABLE ITEMS (#101.43)
 ;ORDER QUICK VIEW (#101.44)
 ;CPRS QUERY DEFINITION (#102.21)
 ;CPRS QUERY CONSTRAINT (#102.22)
 ;CPRS QUERY EDIT CONTROL (#102.23)
 ;CPRS QUERY DISPLAY FIELDS (#102.24)
 ;
