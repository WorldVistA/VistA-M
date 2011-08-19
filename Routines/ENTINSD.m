ENTINSD ;WOIFO/SAB - IT NON-SPACE FILE LOCATION DD CALLS ;2/4/2008
 ;;7.0;ENGINEERING;**87**;Aug 17, 1993;Build 16
 Q
 ;
NSPT(DA,ENF) ; NON-SPACE FILE LOCATION triggers of the NON-SPACE FILE PERSON
 ; and NON-SPACE FILE DATE/TIME fields
 ; called by new-style MUMPS field x-ref logic on NON-SPACE FILE
 ; LOCATION (#90) field of file 6914 when value changes
 ;
 ; input
 ;   DA - ien of entry in file 6914
 ;   ENF - flag, "S" for set logic or "K" for kill logic
 ;
 Q:'$G(DA)  ; ien required
 Q:"^S^K^"'[("^"_ENF_"^")  ; must be S or K
 ;
 N ENFDA
 S ENFDA(6914,DA_",",90.1)=$S(ENF="S":DUZ,1:"@") ; non-space file person
 S ENFDA(6914,DA_",",90.2)=$S(ENF="S":$$NOW^XLFDT(),1:"@") ; date/time
 D FILE^DIE("","ENFDA")
 Q
 ;
BUL(DA) ; Send a bulletin
 ; called by new-style MUMPS record x-ref set logic on NON-SPACE FILE
 ; LOCATION (#90) field of file 6914 when value changes
 ;
 ; input
 ;   DA - ien of entry in file 6914
 ;
 Q:'$G(DA)  ; ien required
 ;
 ; new all input and output variables of the bulletin API
 N XMDUZ,XMBNAME,XMPARM,XMBODY,XMTO,XMINSTR,XMATTACH,XMZ,XMERR
 ;
 ; set variables for the bulletin API
 S XMDUZ=DUZ ; sender
 S XMBNAME="EN NON-SPACE FILE LOC" ; bulletin name
 S XMTO("G.EN NON-SPACE FILE LOC")="" ; mail group
 S XMTO(DUZ)=""
 S XMPARM(1)=DA ; equipment entry #
 S XMPARM(2)=$$GET1^DIQ(6914,DA_",",90) ; non-space file location
 S XMPARM(3)=$$GET1^DIQ(6914,DA_",",90.1) ; non-space file person
 S XMPARM(4)=$$GET1^DIQ(6914,DA_",",90.2) ; non-space file date/time
 ;
 ; send the bulletin
 D SENDBULL^XMXAPI(XMDUZ,XMBNAME,.XMPARM,"",.XMTO)
 Q
 ;
DELNSP(DA) ; Delete Non-Space File Location (#90) field value
 ; called by new-style MUMPS field x-ref set logic on LOCATION (#24)
 ; field of file 6914 when LOCATION value changes
 ;
 ; input
 ;   DA - ien of entry in file 6914
 ;
 Q:'$G(DA)  ; ien required
 ;
 N ENFDA
 S ENFDA(6914,DA_",",90)="@"
 D FILE^DIE("","ENFDA")
 Q
 ; ENTINSD
