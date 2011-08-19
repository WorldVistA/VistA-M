LRBLDRR3 ;DALISC/CYM   DONOR AUDIT TRAIL ; 2/26/96  14:30
 ;;5.2;LAB SERVICE;**90,247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 ;
 ; Routine called by file 65.5 input template LRBLDCP
 ; Multiple field arrays are built and totaled before and after
 ; editing LRBLDCP to be used for comparison.  If total after
 ; editing is less than before editing, then the appropriate
 ; fields contained in the deleted node are put onto the
 ; audit trail for Blood Bank
 ;
BEG ; Counts all donation dates for a patient before editing and puts 
 ; into an array.  Then counts total to be used for comparison later.
 S (LRDATE,BEGDATE)=0
 F  S LRDATE=$O(^LRE(LRDONOR,5,LRDATE)) Q:LRDATE'>0  S BEGDATE=BEGDATE+1,BEG(LRDATE)=^LRE(LRDONOR,5,LRDATE,0)
 Q
DEL ; Counts all donation dates for a patient after editing.  If the
 ; total after editing is less than the total before editing,
 ; the original deleted data is put into the audit trail.
 S (LRDATE,AFTDATE)=0
 F  S LRDATE=$O(^LRE(LRDONOR,5,LRDATE)) Q:LRDATE'>0  S AFTDATE=AFTDATE+1
 I AFTDATE<BEGDATE D
 . Q:'$D(NODE)
 . S O=$P(NODE,U),Z="65.54,.01" D AUDIT
 . S O=$P(NODE,U,2),Z="65.54,1" D AUDIT
 . S O=$P(NODE,U,3),Z="65.54,3" D AUDIT
 . S O=$P(NODE,U,4),Z="65.54,4" D AUDIT
 . S O=$P(NODE,U,5),Z="65.54,5" D AUDIT
 . S O=$P(NODE,U,6),Z="65.54,.02" D AUDIT
 . S O=$P(NODE,U,7),Z="65.54,.03" D AUDIT
 . S O=$P(NODE,U,8),Z="65.54,.011" D AUDIT
 . S O=$P(NODE,U,9),Z="65.54,6" D AUDIT
 . S O=$P(NODE,U,10),Z="65.54,6.1" D AUDIT
 . S O=$P(NODE,U,11),Z="65.54,1.1" D AUDIT
 . S O=$P(NODE,U,12),Z="65.54,1.2" D AUDIT
 . Q:'$D(NODE1)
 . S O=$P(NODE1,U),Z="65.54,4.1" D AUDIT
 . S O=$P(NODE1,U,2),Z="65.54,4.2" D AUDIT
 . S O=$P(NODE1,U,3),Z="65.54,4.3" D AUDIT
 . S O=$P(NODE1,U,4),Z="65.54,4.4" D AUDIT
 . S O=$P(NODE1,U,5),Z="65.54,4.5" D AUDIT
 . S O=$P(NODE1,U,6),Z="65.54,4.6" D AUDIT
 . S O=$P(NODE1,U,7),Z="65.54,4.7" D AUDIT
 . S O=$P(NODE1,U,8),Z="65.54,4.8" D AUDIT
 . S O=$P(NODE1,U,9),Z="65.54,4.11" D AUDIT
 . S O=$P(NODE1,U,10),Z="65.54,4.15" D AUDIT
 Q
 ;
AUDIT I O]"" S X="Deleted" D EN^LRUD
 Q
