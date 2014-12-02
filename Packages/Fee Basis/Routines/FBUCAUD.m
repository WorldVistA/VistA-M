FBUCAUD ;WCIOFO/SAB - FEE BASIS 162.7 DATA AUDIT ;5/19/2014
 ;;3.5;FEE BASIS;**151**;JAN 30, 1995;Build 14
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
AUD(FBSET) ; audit of selected fields in file 162.7
 ;called by set and kill logic of AUD mumps x-ref on file 162.7
 ; input
 ;   FBSET = 0 or 1, =true if set logic and =false if kill logic
 ;   also variables from FileMan x-ref
 ;     DA = IEN of record in file 162.7
 ;     X1(#) = old values of cross-referenced fields
 ;     X2(#) = new values of cross-referenced fields
 N FBDT,FBI,FBFDA,FBFIELDL
 ; list of cross-referenced fields in order number
 S FBFIELDL="24^10^.01^19.6^7^11^21^50^51^52^53^54^55"
 S FBDT=$$NOW^XLFDT()
 ;
 ; if kill logic and new value of .01 field null then record was deleted
 ;   and no need to proceed since audit multiple is stored in record
 I 'FBSET,X2(3)="" Q
 ;
 ; if old and new field values are different then save change in audit
 ; loop thru audited fields
 F FBI=1:1:13 D
 . ; if kill logic and value was deleted then save audit
 . I 'FBSET,X1(FBI)'=X2(FBI),X2(FBI)="" D SAVE
 . ; if set logic and value was entered or changed then save audit
 . I FBSET,X1(FBI)'=X2(FBI),X2(FBI)'="" D SAVE
 Q
 ;
SAVE ;
 N FBFDA,FBIENS
 S FBIENS="+1,"_DA_","
 S FBFDA(162.793,FBIENS,.01)=FBDT ; CHANGED DATE/TIME
 S FBFDA(162.793,FBIENS,1)=$P(FBFIELDL,"^",FBI) ; FIELD
 S FBFDA(162.793,FBIENS,2)=X1(FBI) ; OLD VALUE
 S FBFDA(162.793,FBIENS,3)=X2(FBI) ; NEW VALUE
 S FBFDA(162.793,FBIENS,4)=DUZ ; CHANGED BY
 D UPDATE^DIE("","FBFDA")
 Q
 ;
OUTX ; output transform
 ; called by OLD VALUE and NEW VALUE fields in the DATA AUDIT multiple
 ; of the FEE BASIS UNAUTHORIZED CLAIMS (#162.7) file.
 ; input
 ;   Y   = value to transform
 ;   D0  = required internal entry number, top level
 ;   D1  = optional internal entry number, one level below
 ;   DIC = optional file/sub-file root
 ; output
 ;   Y   = external value for Y when available, else the input value
 ;
 Q:'$G(D0)  ; must have at least one IEN
 Q:$G(Y)=""  ; must have internal value to transform
 ;
 N FBFLD,FBNODE,FBY
 ;
 ; determine 0-node of entry in DATA AUDIT
 S FBNODE=""
 I $G(D1) S FBNODE="^FB583("_D0_",""LOG2"","_D1_",0)"
 I '$G(D1),$E($G(DIC))="^" S FBNODE=DIC_D0_",0)"
 Q:FBNODE=""
 ;
 ; obtain value of FIELD
 S FBFLD=$P($G(@FBNODE),"^",2)
 Q:FBFLD=""
 ;
 ; obtain external value of Y for the field
 S FBY=$$EXTERNAL^DILFD(162.7,FBFLD,"",Y)
 S:FBY]"" Y=FBY ; return external value in Y
 Q
 ;
LTRDT(FBSET) ; trigger on DATE LETTER SENT field in file 162.7
 ; called by set and kill logic on AILT cross-reference
 ; populates DATE REQ INFO SENT field when status order is 10
 ; input
 ;   FBSET = 0 or 1, =true if set logic and =false if kill logic
 ;   also variables from FileMan x-ref
 ;     DA = IEN of record in file 162.7
 ;     X1(1) = old values of cross-referenced field
 ;     X2(1) = new values of cross-referenced field
 ;
 N FBFDA,FBVAL
 ; quit if status order not 10 (i.e. not incomplete unauthorized claim)
 Q:$$ORDER^FBUCUTL($P($G(^FB583(DA,0)),"^",24))'=10
 ;
 S FBVAL=""
 ; if kill logic and value was deleted then delete value
 I 'FBSET,X1(1)'=X2(1),X2(1)="" S FBVAL="@"
 ; if set logic and value was entered or changed then copy date
 I FBSET,X1(1)'=X2(1),X2(1)'="" S FBVAL=X2(1)
 ;
 I FBVAL]"" D
 . S FBFDA(162.7,DA_",",19.6)=FBVAL ; DATE REQ INFO SENT
 . D FILE^DIE("","FBFDA")
 ;
 Q
 ;FBUCAUD
