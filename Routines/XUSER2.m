XUSER2 ;ISF/RWF - New Person File Utilities ;11/04/09  14:28
 ;;8.0;KERNEL;**267,251,344,534**;Jul 10, 1995;Build 6
 ;Per VHA Directive 2004-038, this routine should not be modified.
 Q
VALDEA(X,F) ;Check for a valid DEA#
 ;Returns 0 for NOT Valid, 1 for Valid
 ;F = 1 for Facility DEA check.
 I $D(X) K:$L(X)>9!($L(X)<9)!'(X?2U7N) X
 S F=$G(F)
 I $D(X),'F,$D(DA),$D(^VA(200,"PS1",X)),$O(^(X,0))'=DA D EN^DDIOL($C(7)_"CAN'T FILE: DUPLICATE DEA NUMBER") K X
 I $D(X),'F,$D(DA),$E(X,2)'=$E($P(^VA(200,DA,0),"^")) D EN^DDIOL($C(7)_"WARNING: DEA# FORMAT MISMATCH -- CHECK SECOND LETTER")
 I $D(X),'$$DEANUM(X) D EN^DDIOL($C(7)_"CAN'T FILE: DEA# FORMAT MISMATCH -- NUMERIC ALGORITHM FAILED") K X
 Q $D(X)
 ;
DEANUM(X) ;Check DEA # part
 N VA1,VA2
 S VA1=$E(X,3)+$E(X,5)+$E(X,7)+(2*($E(X,4)+$E(X,6)+$E(X,8)))
 S VA1=VA1#10,VA2=$E(X,9)
 Q VA1=VA2
 ;
VANUM ;Check that the VA# is not Active for anybody else. Called from ^DD(200,53.3,0)
 ;Needs DA, DT and X
 Q:'$D(X)!'$D(DA)
 N %
 I $D(^VA(200,"PS2",X)) D
 . S %=0
 . F  S %=$O(^VA(200,"PS2",X,%)) Q:'%  I %'=DA,$S('$P($G(^VA(200,%,"PS")),"^",4):1,1:$P(^("PS"),"^",4)'<DT) K X Q
 . Q
 I '$D(X) D EN^DDIOL($C(7)_"That VA# is in active use.  ","","!,?5")
 Q
 ;
REQ(XUV,XUFLAG) ;Called from forms:
 ; XUEXISTING USER, XUNEW USER, XUREACT USER, XU-CLINICAL TRAINEE
 ;from the:
 ; - Form-level pre-action
 ; - Post action on change for "Is this person a Clinical Trainee?"
 ;In:
 ; XUV = 1 if user is a clinical trainee; 0 otherwise
 ;          If XUV is not passed, its value is obtained from the
 ;          CLINICAL CORE TRAINEE(#12.6).
 ; XUFLAG = 1 if called from the XU-CLINICAL TRAINEE form;
 ;          otherwise, called from the other forms
 ;
 N BLOCK,PAGE,FIELD,F126
 ; BLOCK = Block
 ; PAGE = Page number
 ; FIELD = Field number
 I $G(XUFLAG) S BLOCK="XU-CLINICAL TRAINEE 1",PAGE=1
 E  D
 . S BLOCK="XUEXISTING USER TRAINEE"
 . S PAGE=5
 ;
 I $G(XUV)="" D  ;Value not Passed get current value
 . N ZERR
 . S XUV=$$GET^DDSVAL(200,DA,"CLINICAL CORE TRAINEE",.ZERR,"I")
 . S XUV=$S(XUV="N":0,XUV="":0,1:1)
 S F126=XUV
 ;
 ;CURRENT DEGREE LEVEL 12.1
 ;PROGRAM OF STUDY 12.2
 ;LAST TRAINING MONTH & YEAR 12.3
 ;VHA TRAINING FACILITY 12.4
 ;DATE HL7 TRAINEE RECORD BUILT 12.5
 ;CLINICAL CORE TRAINEE 12.6
 ;DATE NO LONGER TRAINEE 12.7
 ;START OF TRAINING 12.8
 ;
 I F126 D  Q  ;Logic for when field 12.6 equals YES or Null
 . N FIELD
 . ;Make fields required
 . F FIELD="12.2F","12.4F" D REQ^DDSUTL(FIELD,BLOCK,PAGE,1)
 . ;Delete value in field 12.7 & make it uneditable
 . S FIELD=12.7 D PUT^DDSVAL(200,DA,FIELD,"@","","I")
 . S FIELD="12.7F" D UNED^DDSUTL(FIELD,BLOCK,PAGE,1)
 . D REQ^DDSUTL(FIELD,BLOCK,PAGE,0)
 . ;Make the following fields editable
 . F FIELD="12.1F","12.2F","12.3F","12.4F","12.8F" D UNED^DDSUTL(FIELD,BLOCK,PAGE,0)
 . Q
 I 'F126 D  Q  ;Logic for when field 12.6 equals NO
 . N FIELD,ZERR,F122,F127
 . S F122=$$GET^DDSVAL(200,DA,12.2,.ZERR,"I")
 . S F127=$$GET^DDSVAL(200,DA,12.7,.ZERR,"I")
 . I F122="" D  Q  ;Not a trainee, probably a mistake
 .. ;Make fields not required
 .. F FIELD="12.2F","12.4F" D REQ^DDSUTL(FIELD,BLOCK,PAGE,0)
 .. ;Make field uneditable
 .. F FIELD="12.1F","12.2F","12.3F","12.4F","12.7F","12.8F" D UNED^DDSUTL(FIELD,BLOCK,PAGE,1)
 .. Q
 . I F122]"",F127]"" Q
 . ;Make fields not required
 . F FIELD="12.2F","12.4F" D REQ^DDSUTL(FIELD,BLOCK,PAGE,0)
 . ;Make the following field required & editable
 . S FIELD="12.7F" D REQ^DDSUTL(FIELD,BLOCK,PAGE,1)
 . S FIELD="12.7F" D UNED^DDSUTL(FIELD,BLOCK,PAGE,0)
 . ;Don't allow editing of the following fields
 . F FIELD="12.1F","12.2F","12.3F","12.4F","12.8F" D UNED^DDSUTL(FIELD,BLOCK,PAGE,1)
 . Q
 Q
