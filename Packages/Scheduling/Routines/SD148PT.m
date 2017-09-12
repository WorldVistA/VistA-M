SD148PT ;BP/CMF - UPDATE STANDARD POSTION FILE ;7/17/98@09:30
 ;;5.3;Scheduling;**148T4**;AUG 13, 1993
 ;
 ;;SDA = Fileman Data Array (FDA)
 ;;SDL = Line Reference
 ;;SDERR = Error Message Array
 ;;SDX = Scratch
 ;;SDY = Scratch
 ;
EN N SDA,SDL,SDX,SDY
 ;find out if entry exists
 S SDX=$$FIND1^DIC(403.46,"","X",$$S(1))
 D W(),W(1)
 I SDX=0 D GOOD G ENQ
 I +SDX D OK G ENQ
 D BAD
ENQ Q
 ;
GOOD ;if no entry, create it
 K SDX
 D FDA(1)
 D UPDATE^DIE("","SDA(1)")
 I '$D(DIERR) D W(25),W(26) Q
 D W(37)
 Q
 ;
OK ;if single entry, update/complete it
 D FDA(,SDX)
 D FILE^DIE("","SDA(1)")
 I '$D(DIERR) D W(28),W(29),W(30),W(26) Q
 D W(37)
 Q
 ;
BAD ;if many entries, don't update it
 D W(32),W(25),W(33),W(34),W(35),W(30)
 Q
 ;
FDA(SDY,SDX) ;
 ;input: SDY = .01 field?
 ;input: SDX = filer ien
 ;output: FDA
 I $D(SDY) D
 .S SDX=$$S(4)_$$S(5)
 .S @SDX@(.01)=$$S(1)
 E  S SDX=$$S(4)_""""_SDX_","_""""_")"
 S @SDX@(.02)=274  ;hard set pointer field because USR CLASS
 ;                 ;file may not yet exist on system
 S SDY=$$S(3)
 S @SDX@(1)=SDY
 F SDX=7:1:23 S @SDY@(SDX-6)=$$S(SDX)
 Q
 ;
W(SDX) ;input: SDX=Line reference
 ;output: KIDS Message
 S SDX=$G(SDX,0)
 D MES^XPDUTL($$S(SDX))
 Q
 ;
S(SDL) Q $P($T(T+SDL),";;",2)
 ;
T ;; ;;
1 ;;CLINICAL NURSE SPECIALIST
 ;;NURSE CLINICAL SPECIALIST
 ;;SDA("TEXT")
4 ;;SDA(1,403.46,
 ;;"+1,")
 ;;
7 ;;Masters Degree-prepared, registered nurses with nationally 
 ;;recognized clinical advanced practice certification, accountable for
 ;;the delivery of comprehensive health and preventive care services 
 ;;across the spectrum of clinical settings.  Uses an analytical
 ;;framework, such as nursing process, to create an environment 
 ;;that facilitates the delivery of care.  Coordinates and evaluates
 ;;integrated programs, and provides leadership in improving and
 ;;sustaining the quality and effectiveness of care in diverse or
 ;;complex programs. Function as licensed independent practitioners 
 ;;that do not require "supervision" by a physician, physician 
 ;;countersignature of orders or the care they provide. Function 
 ;;autonomously within a defined scope of practice in 
 ;;collaboration with physicians and other health care providers. 
 ;;[REF: IL 10-97-024, dated July 7, 1997: entitled "Under 
 ;;Secretary for Health's Information Letter - Utilization of Nurse 
 ;;Practitioners and Clinical Nurse Specialists" and Nursing
23 ;;Qualifications Standards - Nurse Level IV]
 ;;
25 ;;added to Standard Position file.
26 ;;You may delete the routine "SD148PT" from your system.
 ;;
28 ;;in your Standard Position file has been updated.
 ;;The user class and description fields have been modified.
30 ;;There should be no local entries in this file!
 ;;
32 ;;has not been
 ;;There are multiple entries of this standard position.
 ;;Clean up the multiple entries, and then run "EN^SD148PT"
35 ;;to add the supported position.
 ;;
37 ;;Error during processing!  Standard Position file not updated!
