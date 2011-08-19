XUOAAUTL ;SFISC/SO- UTILITIES FOR OAA ;09/08/2008
 ;;8.0;KERNEL;**344,398,401**;Jul 10, 1995;Build 3
 ;
SCRN4(IEN) ; Screen for INSITUTION(#4) file
 N DIERR,IENS,FIELDS,Z,ZERR
 S IENS=+IEN_","
 S FIELDS="11;13;101"
 D GETS^DIQ(4,IENS,FIELDS,"IE","Z","ZERR")
 I $D(DIERR) Q 0
 ;
 ;Check to see if National
 I Z(4,IENS,11,"I")'="N" Q 0
 ;
 ;Check to see if Inactive
 I Z(4,IENS,101,"I") Q 0
 ;
 ;Check to see if VAMC ;8*398,8*401
 ; or M&ROC
 ; or RO-OC
 ; or OC
 I "^VAMC^M&ROC^RO-OC^OC^"[(U_Z(4,IENS,13,"E")_U) Q 1
 ;
 ;Default
 Q 0
 ;
HLP1 ; VHA TRAINING FACILITY HELP
 W !,"Please choose the AFFILIATED VA facility responsible for administering"
 W !,"this Registered trainee's clinical training program, even though the trainee's"
 W !,"rotation may physically occur at a secondary VA site (i.e., OPC, CBOC, etc.)."
 Q
 ;
A127 ; Automatically set Date No Longer Trainee, field #12.7
 N IEN S IEN=0
 F  S IEN=$O(^VA(200,IEN)) Q:'IEN  I $D(^VA(200,IEN,12)),$P(^(12),U,2)'="" D
 . I '$D(^VA(200,IEN,0)) Q  ; Bogus entry
 . N TD ; Termination Date
 . S TD=$P(^VA(200,IEN,0),U,11) ; Get Termination Date (TD)
 . N DNLT ; Date No Longer Trainee
 . S DNLT=$P(^VA(200,IEN,12),U,7) ; Get Date No Longer Trainee (DNLT)
 . I TD="" Q  ; User not Terminated
 . I TD>DT Q  ; Future Termination Date
 . I DNLT="" D EDIT Q
 . I DNLT>TD D EDIT Q
 . Q
 Q
EDIT ;
 N DIERR,FDA
 S FDA(200,IEN_",",12.6)="N" ; Set Clinical Core Trainee to No
 S FDA(200,IEN_",",12.7)=TD ; Set Date No Longer Trainee
 D FILE^DIE("","FDA")
 Q
