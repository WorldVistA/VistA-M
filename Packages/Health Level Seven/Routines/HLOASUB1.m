HLOASUB1 ;IRMFO-ALB/CJM/RBN - Subscription Registry (continued) ;07/12/2012
 ;;1.6;HEALTH LEVEL SEVEN;**126,134,138,146,147,158**;Oct 13, 1995;Build 14
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
INDEX(IEN,PARMARY) ;
 ;Allows an application to optionally index its subscriptions.
 ;so that it can find find them without storing the ien.
 ;
 ;Input:
 ;  IEN - ien of the entry
 ;  PARMARY (pass by reference) An array of up to 6 lookup values with
 ;which to build the index.  The format is: PARMARY(1)=<first parameter>,
 ; up to PARMARY(6)
 ;Output:
 ;  function returns 1 on success, 0 otherwise
 ;  PARMARY - left undefined
 ;
 N OWNER,I,NODE
 Q:'$G(IEN) 0
 S OWNER=$P($G(^HLD(779.4,IEN,0)),"^",2)
 Q:'$L(OWNER) 0
 D KILLAH(IEN)
 F I=1:1:6 S:'$L($G(PARMARY(I))) PARMARY(I)=" "
 D SETAH(IEN,OWNER,.PARMARY)
 S NODE=""
 F I=1:1:6 S NODE=NODE_$G(PARMARY(I))_"^"
 S ^HLD(779.4,IEN,3)=NODE
 K PARMARY
 Q 1
 ;
SETAH(IEN,OWNER,PARMS) ;
 Q:'$G(IEN)
 Q:'$L($G(OWNER))
 N INDEX
 S INDEX="^HLD(779.4,""AH"",OWNER,"
 F I=1:1:6 D
 .S:'$L($G(PARMS(I))) PARMS(I)=" "
 .S INDEX=INDEX_""""_PARMS(I)_""","
 S INDEX=$E(INDEX,1,$L(INDEX)-1)_")"
 S @INDEX=IEN
 Q
 ;
SETAH1(DA,OWNER,X1,X2,X3,X4,X5,X6) ;
 Q:'$G(DA)
 Q:'$L($G(OWNER))
 N PARMS,I
 F I=1:1:6 I $L($G(@("X"_I))) S PARMS(I)=@("X"_I)
 D SETAH(DA,OWNER,.PARMS)
 Q
 ;
KILLAH1(OWNER,LOOKUP1,LOOKUP2,LOOKUP3,LOOKUP4,LOOKUP5,LOOKUP6) ;
 Q:'$L(OWNER)
 N I,INDEX
 S INDEX="^HLD(779.4,""AH"",OWNER"
 F I=1:1:6 D
 .S:'$L($G(@("LOOKUP"_I))) @("LOOKUP"_I)=" "
 .S INDEX=INDEX_","_""""_@("LOOKUP"_I)_""""
 S INDEX=INDEX_")"
 K @INDEX
 Q
 ;
KILLAH(IEN) ;kills the AH x~ref on file 779.4 for a particular subscription registry entry=ien
 Q:'$G(IEN)
 N OWNER,X1,X2,X3,X4,X5,X6,I,NODE
 S OWNER=$P($G(^HLD(779.4,IEN,0)),"^",2)
 Q:'$L(OWNER)
 S NODE=$G(^HLD(779.4,IEN,3))
 F I=1:1:6 I $L($P(NODE,"^",I)) S @("X"_I)=$P(NODE,"^",I)
 D KILLAH1(OWNER,.X1,.X2,.X3,.X4,.X5,.X6)
 Q
 ;
FIND(OWNER,PARMARY) ;
 ;Allows an application to find a subscription
 ;list.  The application must maintain a private index in order to
 ;utilize this function, via $$INDEX^HLOASUB()
 ;
 ;Input:
 ;  OWNER - owning application name
 ;  PARMARY  **pass by reference** an array of up to 6 lookup value with which the index was built.  The format is: PARMARY(1)=<first parameter>, PARMARY(2)=<second parameter>  If PARMARY(i)=null, the parameter will be ignored
 ;Output:
 ;  function returns the ien of the subscription list if found, 0 otherwise
 ; PARMARY - left undefined
 ;
 N OK S OK=0
 ;
 D
 .Q:'$D(PARMARY)
 .Q:'$L($G(OWNER))
 .N INDEX,I
 .S INDEX="^HLD(779.4,""AH"",OWNER"
 .F I=1:1:6 D
 ..S:'$L($G(PARMARY(I))) PARMARY(I)=" "
 ..S INDEX=INDEX_","_""""_PARMARY(I)_""""
 .S INDEX=INDEX_")"
 .S OK=+$G(@INDEX)
 K PARMARY
 Q OK
 ;
UPD(FILE,DA,DATA,ERROR) ;File data into an existing record.
 ; Input:
 ;   FILE - File or sub-file number
 ;   DA - Traditional DA array, with same meaning.
 ;            Pass by reference.
 ;   DATA - Data array to file (pass by reference)
 ;          Format: DATA(<field #>)=<value>
 ;
 ; Output:
 ;  Function Value -     0=error and 1=no error
 ;  ERROR - optional error message - if needed, pass by reference
 ;
 ; Example: To update a record in subfile 2.0361 in record with ien=353,
 ;          subrecord ien=68, with the field .01 value = 21:
 ;    S DATA(.01)=21,DA=68,DA(1)=353 I $$UPD(2.0361,.DA,.DATA,.ERROR) W !,"DONE"
 ;
 N FDA,FIELD,IENS,ERRORS
 ;
 ;IENS - Internal Entry Number String defined by FM
 ;FDA - the FDA array as defined by FM
 ;
 I '$G(DA) S ERROR="IEN OF RECORD TO BE UPDATED NOT SPECIFIED" Q 0
 S IENS=$$IENS^DILF(.DA)
 S FIELD=0
 F  S FIELD=$O(DATA(FIELD)) Q:'FIELD  D
 .S FDA(FILE,IENS,FIELD)=$G(DATA(FIELD))
 D FILE^DIE("","FDA","ERRORS(1)")
 I +$G(DIERR) D
 .S ERROR=$G(ERRORS(1,"DIERR",1,"TEXT",1))
 E  D
 .S ERROR=""
 ;
 D CLEAN^DILF
 Q $S(+$G(DIERR):0,1:1)
 ;
ADD(FILE,DA,DATA,ERROR,IEN) ;
 ;Description: Creates a new record and files the data.
 ; Input:
 ;   FILE - File or sub-file number
 ;   DA - Traditional FileMan DA array with same
 ;            meaning. Pass by reference.  Only needed if adding to a
 ;            subfile.
 ;   DATA - Data array to file, pass by reference
 ;          Format: DATA(<field #>)=<value>
 ;   IEN - internal entry number to use (optional)
 ;
 ; Output:
 ;   Function Value - If no error then it returns the ien of the created record, else returns NULL.
 ;  DA - returns the ien of the new record, NULL if none created.  If needed, pass by reference.
 ;  ERROR - optional error message - if needed, pass by reference
 ;
 ; Example: To add a record in subfile 2.0361 in the record with ien=353
 ;          with the field .01 value = 21:
 ;  S DATA(.01)=21,DA(1)=353 I $$ADD(2.0361,.DA,.DATA) W !,"DONE"
 ;
 ; Example: If creating a record not in a subfile, would look like this:
 ;          S DATA(.01)=21 I $$ADD(867,,.DATA) W !,"DONE"
 ;
 N FDA,FIELD,IENA,IENS,ERRORS
 ;
 ;IENS - Internal Entry Number String defined by FM
 ;IENA - the Internal Entry Number Array defined by FM
 ;FDA - the FDA array defined by FM
 ;IEN - the ien of the new record
 ;
 S DA="+1"
 S IENS=$$IENS^DILF(.DA)
 S FIELD=0
 F  S FIELD=$O(DATA(FIELD)) Q:'FIELD  D
 .S FDA(FILE,IENS,FIELD)=$G(DATA(FIELD))
 I $G(IEN) S IENA(1)=IEN
 D UPDATE^DIE("","FDA","IENA","ERRORS(1)")
 I +$G(DIERR) D
 .S ERROR=$G(ERRORS(1,"DIERR",1,"TEXT",1))
 .S IEN=""
 E  D
 .S IEN=IENA(1)
 .S ERROR=""
 D CLEAN^DILF
 S DA=IEN
 Q IEN
 ;
DELETE(FILE,DA,ERROR)   ;Delete an existing record.
 N DATA
 S DATA(.01)="@"
 Q $$UPD(FILE,.DA,.DATA,.ERROR)
 Q
 ;
STATNUM(IEN) ;
 ;Description:  Given an ien to the Institution file, returns as the function value the station number. If IEN is NOT passed in, it assumes the local site.  Returns "" on failure.
 ;
 N STATION,RETURN
 S RETURN=""
 I $G(IEN) D
 .Q:'$D(^DIC(4,IEN,0))
 .S STATION=$P($$NNT^XUAF4(IEN),"^",2)
 .S RETURN=$S(+STATION:STATION,1:"")
 E  D
 .S RETURN=$P($$SITE^VASITE(),"^",3)
 Q RETURN
 ;
CHECKWHO(WHO,PARMS,ERROR) ;
 ;Checks the parameters provided in WHO() (see $$ADD).  They must resolve
 ;the link, receiving app and receiving facility.
 ;INPUT:
 ;  WHO - (required, pass by reference) - see $$ADD.
 ;
 ;  WHO("PORT") - if this is valued, it will be used as the remote port
 ;    to connect with rather than the port associated with the link
 ;Output:
 ;  Function returns 1 if the input is resolved successfully, 0 otherwise
 ;    PARMS - (pass by reference)  These subscripts are returned:
 ;     "LINK IEN" - ien of the link overwhich to transmit (could be middleware)
 ;     "LINK NAME" - name of the link
 ;     "LINK PORT" - port #
 ;     "RECEIVING APPLICATION"  - name of the receiving app
 ;     "RECEIVING FACILITY",1)  - component 1
 ;     "RECEIVING FACILITY",2) - component 2
 ;     "RECEIVING FACILITY",3) - component 3
 ;     "RECEIVING FACILITY","LINK IEN") - ien of facility
 ;   ERROR - (pass by reference) - if unsuccessful, an error message is returned.
 ;
 N OK
 K ERROR
 S OK=1
 S PARMS("LINK IEN")="",PARMS("LINK NAME")=""
 ;must identify the receiving app
 ;
 D
 .N LEN
 .S LEN=$L($G(WHO("RECEIVING APPLICATION")))
 .I 'LEN S OK=0
 .E  I LEN>60 S OK=0
 .S:'OK ERROR="RECEIVING APPLICATION NOT VALID"
 .S PARMS("RECEIVING APPLICATION")=$G(WHO("RECEIVING APPLICATION"))
 ;
 ;find the station # if Institution ien known
 S:$G(WHO("INSTITUTION IEN")) WHO("STATION NUMBER")=$$STATNUM^HLOASUB1(WHO("INSTITUTION IEN"))
 ;
 ;if destination link specified by name, get its ien
 I '$G(WHO("FACILITY LINK IEN")),$L($G(WHO("FACILITY LINK NAME"))) S WHO("FACILITY LINK IEN")=$O(^HLCS(870,"B",WHO("FACILITY LINK NAME"),0))
 ;
 ;if destination link not specified, find it based on station #
 I $L($G(WHO("STATION NUMBER"))),'$G(WHO("FACILITY LINK IEN")) S WHO("FACILITY LINK IEN")=$$FINDLINK^HLOTLNK(WHO("STATION NUMBER"))
 ;
 ;if station # not known, find it based on destination link
 I '$L($G(WHO("STATION NUMBER"))),$G(WHO("FACILITY LINK IEN")) S WHO("STATION NUMBER")=$$STATNUM^HLOTLNK(WHO("FACILITY LINK IEN"))
 ;
 S PARMS("RECEIVING FACILITY",1)=$G(WHO("STATION NUMBER"))
 ;
 ;if the destination link is known, get the domain
 S PARMS("RECEIVING FACILITY",2)=$S($G(WHO("FACILITY LINK IEN")):$$DOMAIN^HLOTLNK(WHO("FACILITY LINK IEN")),1:"")
 ;
 ;**P146 START CJM
 S PARMS("RECEIVING FACILITY","LINK IEN")=$G(WHO("FACILITY LINK IEN"))
 ;**P146 END CJM
 ;
 S PARMS("RECEIVING FACILITY",3)="DNS"
 ;
 ;find the link to send over - need name & ien
 I $G(WHO("MIDDLEWARE LINK IEN")) S WHO("IE LINK IEN")=WHO("MIDDLEWARE LINK IEN")
 I $L($G(WHO("MIDDLEWARE LINK NAME"))) S WHO("IE LINK NAME")=WHO("MIDDLEWARE LINK NAME")
 I $G(WHO("IE LINK IEN")) D
 .S PARMS("LINK IEN")=WHO("IE LINK IEN")
 .S PARMS("LINK NAME")=$P($G(^HLCS(870,PARMS("LINK IEN"),0)),"^")
 .I OK,'$L(PARMS("LINK NAME")) S OK=0,ERROR="MIDDLEWARE LOGICAL LINK PROVIDED BUT NOT FOUND"
 E  I $L($G(WHO("IE LINK NAME"))) D
 .S PARMS("LINK NAME")=WHO("IE LINK NAME")
 .S PARMS("LINK IEN")=$O(^HLCS(870,"B",WHO("IE LINK NAME"),0))
 .I OK,'PARMS("LINK IEN") S OK=0,ERROR="MIDDLEWARE LOGICAL LINK PROVIDED BUT NOT FOUND"
 E  I $G(WHO("FACILITY LINK IEN")) D
 .S PARMS("LINK IEN")=WHO("FACILITY LINK IEN")
 .S PARMS("LINK NAME")=$P($G(^HLCS(870,PARMS("LINK IEN"),0)),"^")
 .I OK,'$L(PARMS("LINK NAME")) S OK=0,ERROR="RECEIVING FACILITY LOGICAL LINK NOT FOUND"
 E  I $L($G(WHO("FACILITY LINK NAME"))) D
 .S PARMS("LINK NAME")=WHO("FACILITY LINK NAME")
 .S PARMS("LINK IEN")=$O(^HLCS(870,"B",WHO("FACILITY LINK NAME"),0))
 .;; ** Start HL*1.6*138 - RBN **
 .;I OK,'PARMS("LINK IEN") S OK=0,ERROR="RECEIVING FACILITY LOGICAL LINK NOT FOUND"
 .I OK,'PARMS("LINK IEN") S OK=0,ERROR="NEITHER THE RECEIVING FACILITY STATION # NOR THE DOMAIN IS SPECIFIED. AT LEAST ONE OR THE OTHER MUST BE SPECIFIED."
 .;; ** Start HL*1.6*138 - RBN **
 I OK,(('PARMS("LINK IEN"))!(PARMS("LINK NAME")="")) S OK=0,ERROR="LOGICAL LINK TO TRANSMIT OVER NOT SPECIFIED"
 ;
 ;need the station # or domain for msg header
ZB25 I OK,'$L(PARMS("RECEIVING FACILITY",2)),'PARMS("RECEIVING FACILITY",1) S OK=0,ERROR="NEITHER THE RECEIVING FACILITY STATION # NOR THE DOMAIN IS SPECIFIED. AT LEAST ONE OR THE OTHER MUST BE SPECIFIED."
 ;
 ;append the port#
 I '$G(WHO("PORT")) S PARMS("RECEIVING FACILITY",2)=PARMS("RECEIVING FACILITY",2)_":"_$$PORT^HLOTLNK($G(WHO("FACILITY LINK IEN")))
 E  S PARMS("RECEIVING FACILITY",2)=PARMS("RECEIVING FACILITY",2)_":"_WHO("PORT")
 ;**P158 START **
 I $G(WHO("PORT")) S PARMS("LINK PORT")=WHO("PORT")
 E  I $G(PARMS("LINK IEN")) S PARMS("LINK PORT")=$$PORT^HLOTLNK(PARMS("LINK IEN"))
 ;**P158 END **
 ;
 Q OK
 ;
 ;**P146 START CJM
ONLIST(IEN,WHO) ;
 ;Description:
 ;  Determines if a recipient is already on the subscriber list
 ;
 ;Input:
 ;  IEN - ien of subscription
 ;  WHO (pass by reference) Identifies the recipient. The allows
 ;      subscripts are the same as in ADD^HLOASUB.
 ;
 ;Output:
 ;   Function returns 0 if not on the subscription list, otherwise
 ;      returns the ien of the subscriber on the subscription list.
 ;
 N PARMS,SUBIEN,TLINK
 S SUBIEN=0
 ;
 ;resolve input parameters
 I '$$CHECKWHO(.WHO,.PARMS) Q 0
 ;
 ;check the "AE" xref
 S SUBIEN=$O(^HLD(779.4,IEN,2,"AE",PARMS("RECEIVING APPLICATION"),+$G(PARMS("RECEIVING FACILITY","LINK IEN")),+$G(PARMS("LINK IEN")),0))
 I SUBIEN Q SUBIEN
 I PARMS("RECEIVING FACILITY","LINK IEN")=PARMS("LINK IEN") S SUBIEN=$O(^HLD(779.4,IEN,2,"AE",PARMS("RECEIVING APPLICATION"),+$G(PARMS("RECEIVING FACILITY","LINK IEN")),0,0))
 I SUBIEN Q SUBIEN
 ;
 ;check the "AD" xref
 I PARMS("LINK IEN"),PARMS("LINK IEN")'=PARMS("RECEIVING FACILITY","LINK IEN") D
 .S TLINK=PARMS("LINK IEN")
 E  S TLINK=PARMS("RECEIVING FACILITY","LINK IEN")
 ;
 Q +$O(^HLD(779.4,IEN,2,"AD",PARMS("RECEIVING APPLICATION"),+TLINK,PARMS("RECEIVING FACILITY",1)_PARMS("RECEIVING FACILITY",2)_PARMS("RECEIVING FACILITY",3),0))
 ;
 ;**P146 END CJM
