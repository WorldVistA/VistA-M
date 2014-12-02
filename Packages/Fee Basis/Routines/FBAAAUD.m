FBAAAUD ;WCIOFO/SAB - FEE BASIS FILE 161.01 DATA AUDIT ;3/26/2014
 ;;3.5;FEE BASIS;**151**;JAN 30, 1995;Build 14
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
AUD(FBSET) ; audit of selected fields in sub-file 161.01
 ; called by set and kill logic of AUD mumps x-ref on sub-file 161.01
 ; input
 ;   FBSET = 0 or 1, =true if set logic and =false if kill logic
 ;   also variables from FileMan x-ref
 ;     DA(1) = IEN of record in file 161
 ;     DA = IEN of record in sub-file 161.01
 ;     X1(#) = old values of cross-referenced fields
 ;     X2(#) = new values of cross-referenced fields
 N FBDT,FBI,FBFDA,FBFIELDL
 ; list of cross-referenced fields in order number
 S FBFIELDL=".01^.02^.06^.07^.095"
 S FBDT=$$NOW^XLFDT()
 ;
 ; if kill logic and new value of .01 field null then record was deleted
 ;   and no need to proceed since audit multiple is stored in record
 I 'FBSET,X2(1)="" Q
 ;
 ; if old and new field values are different then save change in audit
 ; loop thru audited fields
 F FBI=1:1:5 D
 . ; if kill logic and value was deleted then save audit
 . I 'FBSET,X1(FBI)'=X2(FBI),X2(FBI)="" D SAVE
 . ; if set logic and value was entered or changed then save audit
 . I FBSET,X1(FBI)'=X2(FBI),X2(FBI)'="" D SAVE
 Q
 ;
SAVE ;
 N FBFDA,FBIENS
 S FBIENS="+1,"_DA_","_DA(1)_","
 S FBFDA(161.193,FBIENS,.01)=FBDT ; CHANGED DATE/TIME
 S FBFDA(161.193,FBIENS,1)=$P(FBFIELDL,"^",FBI) ; FIELD
 S FBFDA(161.193,FBIENS,2)=X1(FBI) ; OLD VALUE
 S FBFDA(161.193,FBIENS,3)=X2(FBI) ; NEW VALUE
 S FBFDA(161.193,FBIENS,4)=DUZ ; CHANGED BY
 D UPDATE^DIE("","FBFDA")
 Q
 ;
OUTX ; output transform
 ; called by OLD VALUE and NEW VALUE fields in the DATA AUDIT multiple
 ; in the AUTHORIZATION multiple of the FEE BASIS PATIENT (#161) file.
 ; input
 ;   Y   = value to transform
 ;   D0  = required internal entry number, top level
 ;   D1  = optional internal entry number, one level below
 ;   D2  = optional internal entry number, two levels below
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
 I $G(D2),$G(D1) S FBNODE="^FBAAA("_D0_",1,"_D1_",""LOG2"","_D2_",0)"
 I '$G(D2),$G(D1),$E($G(DIC))="^" S FBNODE=DIC_D0_",""LOG2"","_D1_",0)"
 I '$G(D2),'$G(D1),$E($G(DIC))="^" S FBNODE=DIC_D0_",0)"
 Q:FBNODE=""
 ;
 ; obtain value of FIELD
 S FBFLD=$P($G(@FBNODE),"^",2)
 Q:FBFLD=""
 ;
 ; obtain external value of Y for the field
 S FBY=$$EXTERNAL^DILFD(161.01,FBFLD,"",Y)
 S:FBY]"" Y=FBY ; return external value in Y
 Q
 ;
 ;FBAAAUD
