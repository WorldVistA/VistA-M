SPNLUTL1 ;HISC/WAA/CM-SCD REGISTRY FILE UTILITIES #2 ;8/6/96  15:51
 ;;2.0;Spinal Cord Dysfunction;**12,14**;01/02/1997
 ;
 ; This routine is a utility routine that will contain the code
 ; that will be used in Screen Manager calls.
 ; 
 ;EN1(SPNLDFN)
 ; This call is use in the SCREENMAN form SPNLPFM1.  It will
 ; load several varables that are going to be passed back to
 ; The calling form.
 ;INPUT:
 ; SPNLDFN  = Patient DFN
 ;OUTPUT:
 ; SPNLSSN  = Patient SSN
 ; SPNLDOB  = Patient date of birth
 ; SPNLDEAD = Patient date of death
 ; SPNLINDC = SCI/SCD patient indicator
 ; SPNLPHON = Patient phone number
 ;
 ;EN2
 ; This function will is to determine if a patient has a given
 ; reaction.
 ;INPUT:
 ; SPNLDFN  = Patient DFN
 ; SPNLETO  = Freetext of Patient Etiology
 ;OUTPUT:
 ;   1 = Patient has the given Etiology
 ;   0 = Patient doesn't have the Etiology
 ;  "" = Etiology doesn't exist
 ;
 ;EN3
 ; This function will is to determine if a patient has a given
 ; reaction for the current entry.
 ;INPUT:
 ; SPNLDFN  = Patient DFN
 ; SPNLETO  = Freetext of Patient Etiology
 ;OUTPUT:
 ;   1 = Patient has the given Etiology
 ;   0 = Patient doesn't have the Etiology
 ;  "" = Etiology doesn't exist
 ;
 ;EN4
 ; This function will determine if a patient has a given Type of CAUSE.
 ;INPUT:
 ;  SPNLDFN  = Patient DFN
 ;  SPNLTYPE = Type of CAUSE
 ;             [Values to be passed are TC, NTC, B, U]
 ;OUTPUT
 ;    1 = Patient has That type of cause
 ;    0 = Patient doesn't have that cause
 ;   "" = Error in function
 ;
 ;EN5
 ; This function will total up all the Chart scors for a patient.
 ;INPUT:
 ;   SPNFDFN = Patient DFN
 ;OUTPUT;
 ;        "" = Error
 ;       1 to 500 = Value of all chart scores added.
 ;
EN1(SPNLDFN) ; Load Form SPNLPFM1
 N SPND1
 Q:SPNLDFN<1
 S (SPNLSSN,SPNLDOB,SPNLDEAD,SPNLINDC,SPNLPHON)=""
 S SPNLSSN=$$GET^DDSVAL(2,.SPNLDFN,.09,1)
 S Y=$$GET^DDSVAL(2,.SPNLDFN,.03,1) X ^DD("DD") S SPNLDOB=Y K Y
 S Y=$$GET^DDSVAL(2,.SPNLDFN,.351,1) I Y>1 X ^DD("DD") S SPNLDEAD=Y K Y
 S SPNLINDC=$$GET^DDSVAL(2,.SPNLDFN,57.4,"","E")
 S SPNLPHON=$$GET^DDSVAL(2,.SPNLDFN,.131,1)
 S SPND1=0
 F  S SPND1=$O(^SPNL(154,SPNLDFN,"E",SPND1)) Q:SPND1<1  D
 . N SPNX,SPNCK
 . S SPNX=SPND1
 . S SPNX(1)=SPNLDFN
 . S SPNCK=$$EN3^SPNLUTL1(.SPNX,"OTHER")
 . D UNED^DDSUTL("DESC OTHER","SPNLPBLK2",1,('SPNCK),SPND1_","_SPNLDFN_",")
 . Q
 Q
EN2(SPNLDFN,SPNLETO) ; Find patient Etiology
 N SPNLETO1,SPNLIEN,SPNLFLG
 S SPNLFLG=""
 I SPNLDFN<1!(SPNLETO="") Q SPNLFLG
 S SPNLETO1=$O(^SPNL(154.03,"B",SPNLETO,0)) I SPNLETO1<1 Q SPNLFLG
 S SPNLFLG=0
 S SPNLIEN=0 F  S SPNLIEN=$O(^SPNL(154,SPNLDFN,"E",SPNLIEN)) Q:SPNLIEN<1  I $P($G(^SPNL(154,SPNLDFN,"E",SPNLIEN,0)),U)=SPNLETO1 S SPNLFLG=1 Q
 Q SPNLFLG
EN3(SPNLDA,SPNLETO) ; Check to see if a given entry us of a given type.
 N SPNLTXT,SPNLFLG
 S SPNLFLG=0
 S SPNLET1=+$P(^SPNL(154,SPNLDA(1),"E",SPNLDA,0),U)
 S SPNLTXT=$P($G(^SPNL(154.03,SPNLET1,0)),U)
 I SPNLTXT[SPNLETO S SPNLFLG=1
 Q SPNLFLG
EN4(SPNLDFN,SPNLTYPE) ; Find patient Type of cause.
 N SPNLIEN,SPNLETO,SPNLFLG
 S SPNLFLG=""
 I "^TC^NTC^B^U^"'[(U_SPNLTYPE_U) Q SPNLFLG
 S SPNLFLG=0
 I SPNLTYPE="B" G BOTH
 S SPNLIEN=0 F  S SPNLIEN=$O(^SPNL(154,SPNLDFN,"E",SPNLIEN)) Q:SPNLIEN<1  S SPNLETO=+$P($G(^SPNL(154,SPNLDFN,"E",SPNLIEN,0)),U) I $P($G(^SPNL(154.03,SPNLETO,0)),U,2)=SPNLTYPE S SPNLFLG=1 Q
BOTH I SPNLTYPE="B" S SPNLIEN=0 F  S SPNLIEN=$O(^SPNL(154,SPNLDFN,"E",SPNLIEN)) Q:SPNLIEN<1  S SPNLETO=+$P($G(^SPNL(154,SPNLDFN,"E",SPNLIEN,0)),U) I $P($G(^SPNL(154.03,SPNLETO,0)),U,2)'="U" S SPNLFLG=1 Q
 Q SPNLFLG
EN5(SPNFDFN) ; Add CHART SCORES
 N SPNFVAL,SPNFPC
 S SPNFVAL=""
 F SPNFPC=4.1:.1:4.6 S SPNFVAL=($$GET^DDSVAL(154.1,.SPNFDFN,SPNFPC,"","I"))+SPNFVAL
 Q SPNFVAL
