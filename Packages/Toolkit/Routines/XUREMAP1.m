XUREMAP1 ;VISS/CEP - Remote Application Registration ; JAN 15, 2025
 ;;8.0;KERNEL;**759**;Jul 10, 1995;Build 40
 ;Per VA Directive 6402, this routine should not be modified.
 Q
GETCNTXT(OUTCTXT,XUCONTXT,OUTINDEX)   ; get Context Option (file #19) details for each entry
 ;
 ;INPUT:
 ;  XUCONTXT:  Name (#.01 ) from option File (#19) of B-Type Option
 ;  OUTINDEX: [optional] positive integer to use as first subscript in return array. 
 ;
 ;RETURN:
 ;  OUTCTXT--OUTPUT ARRAY BY REFERENCE.  SEE DOCUMENTATION FROM RAQ2 FOR CONTEXT OPTION FORMAT
 ;
 N IENS,IEN19,ERRS
 I '$G(OUTINDEX)!(OUTINDEX=0) S OUTINDEX=1
 S OUTCTXT="OUTCTXT("_OUTINDEX_")"
 ;
 S IEN19=$$FINDOPT^XUREMAP1(XUCONTXT)
 I +IEN19'>0 S OUTCTXT(0)="0^Option "_XUCONTXT_" not found."_U_$P($$SITE^VASITE(),U,3) Q
 ; return array is linked to entry with RAIEN
 S IENS=IEN19_","
 D GETS^DIQ(19,IENS,"**","N",OUTCTXT,"ERRS")
 S OUTCTXT(0)=1_"^Option "_XUCONTXT_" found (IEN: "_IEN19_")."_U_$P($$SITE^VASITE(),U,3)
 Q
 ;
GETFLNUM(XUARR) ; Function returns filenumber from input ^ file name ^ location in array
 ; 
 N ARR,FOUND,FILENUM,FLDNUM,IDATA
 S ARR="XUARR"
 S FOUND=0
 F  S ARR=$Q(@ARR) Q:ARR=""  S FILENUM=+$P($P(@ARR,U),";"),FLDNUM=+$P($P(@ARR,U),";",2),IDATA=$P(@ARR,U,3) D  Q:FOUND
 .  I FLDNUM=".01" S FOUND=FILENUM
 Q FOUND_U_$G(IDATA)_U_$S(+FOUND:$QS(ARR,1),1:"")
 ;
INSPLIT(INARR,ARRM,SUB)    ;
 ; split INARR into an array with top level data (INARR) and
 ; multiple data (ARRM)
 ; SUB = subfile number to split into ARRM
 ;
 N INC,FNO
 I $G(SUB)'>0 S SUB=8994.51
 S INC=0
 F  S INC=$O(INARR(INC)) Q:INC'>0  D
 .  S FNO=$P($G(INARR(INC)),";")
 .  I FNO=SUB D
 ..   S ARRM(INC)=$G(INARR(INC)) ;Add to ARRM array
 ..   K INARR(INC) ;Kill from original array
 Q
FORMAT(RETURN,TOPLEVEL,MULTIPLE,CNTXTM)    ;
 ;    Take top level of entries, multiple entries and Context option
 ;    arrays and return formatted array for IAM specification
 ;
 ;
 N INDEX,RACNT,TOPIEN
 S (INDEX,RACNT)=0
 F  S RACNT=$O(TOPLEVEL("DILIST",2,RACNT)) Q:RACNT'>0  D
 . D TOPLEVEL(.RETURN,.TOPLEVEL,.MULTIPLE,.RACNT,.INDEX,.TOPIEN)
 . D CONTEXT(.RETURN,.CNTXTM,.INDEX,.TOPIEN)
 Q
 ;
TOPLEVEL(RETURN,TOPLEVEL,MULTIPLE,RACNT,INDEX,TOPIEN)   ;
 ;
 ;
 ;
 N FLDNUM,EVALUE,FLDN,CBCNT
 S FLDNUM=0
 F  S FLDNUM=$O(TOPLEVEL("DILIST","ID",RACNT,FLDNUM)) Q:FLDNUM'>0  D
 .    S TOPIEN=$G(TOPLEVEL("DILIST",2,RACNT))
 .    S EVALUE=$G(TOPLEVEL("DILIST","ID",RACNT,FLDNUM))
 .    D ADDELEM(.RETURN,8994.5,FLDNUM,EVALUE,.INDEX)
 .  ; LOOP TO BUILD MULTIPLE RETURN 
 S CBCNT=0
 F  S CBCNT=$O(MULTIPLE(TOPIEN,"DILIST","ID",CBCNT)) Q:CBCNT'>0  D
 .   S FLDN=0
 .   F  S FLDN=$O(MULTIPLE(TOPIEN,"DILIST","ID",CBCNT,FLDN)) Q:FLDN'>0  D
 ..    S EVALUE=$G(MULTIPLE(TOPIEN,"DILIST","ID",CBCNT,FLDN))
 ..    D ADDELEM(.RETURN,8994.51,FLDN,EVALUE,.INDEX)
 Q
CONTEXT(RETURN,CNTXTM,INDEX,TOPIEN) ;
 ; ADD context option (file #19) top level...
 N I,ENTRY,FLDN,EVALUE,WPNODE
 ;
 S ENTRY=$O(CNTXTM(TOPIEN,19,""))
 Q:ENTRY'>0
 S FLDN=0
 F  S FLDN=$O(CNTXTM(TOPIEN,19,ENTRY,FLDN)) Q:FLDN'>0  D
 .  S EVALUE=$G(CNTXTM(TOPIEN,19,ENTRY,FLDN))
 .  S WPNODE=$NA(CNTXTM(TOPIEN,19,ENTRY,FLDN))
 .  I $P(EVALUE,"(",2)=$P(WPNODE,"(",2) D
 ..   S I=0 F  S I=$O(CNTXTM(TOPIEN,19,ENTRY,FLDN,I)) Q:I'>0  D
 ...    S EVALUE=$G(CNTXTM(TOPIEN,19,ENTRY,FLDN,I))
 ...    D ADDELEM(.RETURN,19,FLDN,EVALUE,.INDEX)
 .  E  D
 ..   D ADDELEM(.RETURN,19,FLDN,EVALUE,.INDEX)
 ;
 ; Add the rpc multiple of the context options (ONLY .01 field)
 S ENTRY=0
 F  S ENTRY=$O(CNTXTM(TOPIEN,19.05,ENTRY)) Q:ENTRY'>0  D
 .  S FLDN=0
 .  F  S FLDN=$O(CNTXTM(TOPIEN,19.05,ENTRY,FLDN)) Q:FLDN'>0  D
 ..   S EVALUE=$G(CNTXTM(TOPIEN,19.05,ENTRY,FLDN))
 ..   D ADDELEM(.RETURN,19.05,FLDN,EVALUE,.INDEX)
 ;
 Q
 ;
ADDELEM(ARRAY,FILE,FLDNUM,EVALUE,INDEX) ;
 ; Set a line in the return array
 ; ADD a line (ELEMent) to the return array
 N LABEL
 D FIELD^DID(FILE,FLDNUM,"","LABEL","LABEL")
 S INDEX=INDEX+1
 S ARRAY(INDEX)=FILE_";"_FLDNUM_U_$G(LABEL("LABEL"))_U_EVALUE
 ;
 Q
FAUXFL(XUTEST,NAME,XUARR,XUARRM)  ; test filing a Remote Application Entry under false name
 ;  
 ; INPUT:
 ;     XUARR = top level of input array (see ADDRA^XUREMAP)
 ;     XUARRM  =  multiple array from INSPLIT call
 ; OUTPUT:
 ;     XUTEST = result of ADDRA^XUREMAP1 call
 ;     NAME = name of remote application name parsed from input XUARR
 ;
 N INDEX,FILENUM,FAUXARR,FAUXNM,INPUTFN,XUREMOVE
 ;
 S XUTEST(0)=0 ; no matching entry found
 ;
 ;
 ; grab filenumber, name, index position from input array (fn^.01name^index)
 S INPUTFN=$$GETFLNUM(.XUARR)
 S FILENUM=+INPUTFN
 S NAME=$P(INPUTFN,U,2)
 I $G(NAME)="" D  Q
 .  S XUARR="-1^Remote Application name cannot be empty."
 S INDEX=$P(INPUTFN,U,3)
 ; Attempt filing under faux name
 M FAUXARR=XUARR
 S FAUXNM=$$FAUXNM(NAME) ; return name prepended with XUFAUX (
 S FAUXARR(INDEX)=FILENUM_";.01^NAME^"_FAUXNM
 I FILENUM=8994.5 D ADDRA^XUREMAP1(.XUTEST,.FAUXARR,.XUARRM,-1)
 I FILENUM=19 D ADDEP(.XUTEST,.FAUXARR,"")
 I $G(XUTEST(0))>0 D REMOVE(.XUREMOVE,.FAUXNM,FILENUM)
 Q
 ;
FAUXNM(NAME) ; Return a name to test filing that is unique.
 Q $$TRIM^XLFSTR($E("XUFAUX"_NAME,1,30))
 ;
REMOVE(XURET,XUNAME,FILENUM)  ; remove the Remote Application test entry
 N RAIEN,ERR,MSG,FDA
 S RAIEN=""
 S XURET=0
 S RAIEN=$$FIND1^DIC(FILENUM,"","MX",XUNAME,"","","ERR")
 I +RAIEN D
 .  S FDA(FILENUM,RAIEN_",",.01)="@"
 .  D FILE^DIE("","FDA","MSG")
 .  M XURET=MSG
 E  D
 .  S XURET="-1"_U_XUNAME_" not found.  Deletion not performed."
 Q
 ;
ADDRA(XURET,XUARR,XUARRM,XURAIEN) ; implementation of ADDRA^XUREMAP
 ;
 ;INPUT:
 ;  XUARR: top level file array with data to file
 ;  XUARRM: multiple array with data to file
 ;  XURAIEN:  [optional]
 ;           -1 : don't check for duplicate Authorization codes
 ;           +N : internal entry of 8994.5 entry to overwrite
 ;        
 N APPFDA,APPIEN,STATUS,XUERR,RAIEN
 I '$D(XUARR) S XURET(0)="-1^No data passed" Q
 ;
 ; build top level RA entry FDA array or set error in 
 ; STATUS if input array context option is not found 
 ; in local file 19.
 ;
 S STATUS=$$FDARA(.XUARR,.APPFDA,$G(XURAIEN))
 I +STATUS<1 S XURET(0)=STATUS Q
 ;
 ; FDA for the callback multiple
 I $D(XUARRM) D FDACBM(.XUARRM,.APPFDA)
 I $G(XURAIEN)>0 S APPIEN(1)=XURAIEN
 D UPDATE^DIE("E","APPFDA","APPIEN","XUERR")
 I $D(XUERR("DIERR")) D  Q
 . S XURET(0)="-1^"_$G(XUERR("DIERR",1,"TEXT",1))
 S RAIEN=+$G(APPIEN($O(APPIEN(0))))
 S XURET(0)=1_U_RAIEN_U_$P($$SITE^VASITE(),U,3)
 Q
 ;
FDARA(XUARR,FDA,REPLACE) ; convert XUARR to FDA for REMOTE APP
 ; pass by reference
 ;
 ; If this is a rip and replace then XURAIEN should be defined as
 ; the IEN of the entry being ripped.  The replacement needs to be
 ; stored under the original IEN
 ;
 N ARR,ERROR,IDATA,FILENUM,FLDNAM,FLDNUM,OPT,APPC,COPT
 S ARR="XUARR"
 S (APPC,ERROR,COPT)=0
 F  S ARR=$Q(@ARR) Q:ARR=""  S FILENUM=+$P($P(@ARR,U,1),";",1),FLDNUM=+$P($P(@ARR,U,1),";",2),FLDNAM=$P(@ARR,U,2),IDATA=$P(@ARR,U,3) D  I $G(ERROR) Q
 . I FLDNAM="NAME" D
 ..   I $G(IDATA)="" S ERROR="-1^Remote application name cannot be empty." Q
 . I FLDNAM="CONTEXTOPTION" D  Q
 ..   S COPT=1
 ..   I $G(IDATA)="" S ERROR="-1^Input missing context option." Q
 ..   S OPT=$$FINDOPT($G(IDATA))
 ..   I OPT'>0 S ERROR="-1^Input context option does not exist." Q
 ..   S FDA(FILENUM,"?+1,",FLDNUM)=IDATA
 . I FLDNAM="APPLICATIONCODE" D  Q
 ..   S APPC=1
 ..   I IDATA="" S ERROR="-1^Input missing Application Code." Q
 ..   S IDATA=$$SHAHASH^XUSHSH(256,IDATA,"B")
 ..   ; (faux filing)&(application code already in use)
 ..   I (REPLACE'=-1)&($O(^XWB(8994.5,"ACODE",IDATA,0))>0) S ERROR="-1^Application Code already in use." Q
 ..   S FDA(FILENUM,"?+1,",FLDNUM)=IDATA
 .;
 . S FDA(FILENUM,"?+1,",FLDNUM)=IDATA
 ;
 I ERROR Q ERROR
 I 'COPT S ERROR="-1^Input missing context option node." Q ERROR
 I 'APPC S ERROR="-1^Input missing application code node." Q ERROR
 Q 1
 ;
FDACBM(XUARRM,FDA) ; Add CALLBACKTYPE to known Remote app entry
 ;
 ; Count number of multiple entries.
 ; Each entry may have 4 lines for fields .01, .02, .03, and .04
 ;
 N CBMCNT,ADDCNT,IEN,INC,IENS,ARR,IDATA,FILENUM,FLDNAM,FLDNUM
 S IEN="?+1,"
 S CBMCNT=0
 S ADDCNT=1
 S INC=2
 S IENS="?+"_INC_","
 ;
 S ARR="XUARRM"
 F  S ARR=$Q(@ARR) Q:ARR=""  S FILENUM=+$P($P(@ARR,"^",1),";",1),FLDNUM=+$P($P(@ARR,"^",1),";",2),FLDNAM=$P(@ARR,"^",2),IDATA=$P(@ARR,"^",3) D
 .  I FLDNUM=.01 D
 ..    S CBMCNT=CBMCNT+1
 ..    I ADDCNT'=CBMCNT D
 ...      S IENS="?+"_(INC*CBMCNT)_","
 ...      S ADDCNT=CBMCNT
 .  S FDA(FILENUM,IENS_IEN,FLDNUM)=IDATA
 Q
 ;
FINDOPT(OPT) ; find option OPT
 Q $$FIND1^DIC(19,"","X",$G(OPT),"B")
 ;
ADDEP(XURET,XUARR,FDAIEN) ; implementation of ADDEP^XUREMAP
 ;
 I '$D(XUARR) S XURET(0)="-1^No data passed" Q
 D FDAEP(.XURET,.XUARR,FDAIEN)
 Q
 ;
FDAEP(XURET,XUARR,FDAIEN) ; convert XUARR to FDA for ENDPOINT
 ; pass by reference
 ;
 N ARR,FILENUM,FLDNAM,FLDNUM,IDATA,RPCNT,RPCIEN,WPLINE,WPARRAY,FDA
 S RPCNT=1
 S WPLINE=8
 S ARR="XUARR"
 F  S ARR=$Q(@ARR) Q:ARR=""  S FILENUM=+$P($P(@ARR,"^",1),";",1),FLDNUM=+$P($P(@ARR,"^",1),";",2),FLDNAM=$P(@ARR,"^",2),IDATA=$P(@ARR,"^",3) D
 . I FILENUM=19 D
 ..   ;  for top level fields use standard FDA setup (but handle WP special cases)
 ..   I $$ISFLDWP(FILENUM,FLDNUM) D
 ...    S WPLINE=WPLINE+1
 ...    S WPARRAY(FLDNUM,WPLINE,0)=$P(@ARR,U,3)
 ...    S FDA(19,"?+1,",FLDNUM)="WPARRAY("_FLDNUM_")"
 ..   E  D
 ...    S FDA(FILENUM,"?+1,",FLDNUM)=IDATA
 . I FILENUM=19.05 D
 .. I FLDNUM=.01 D
 ... S RPCIEN=$$FINDRPC(IDATA)
 ... I +$G(RPCIEN) D
 .... S RPCNT=RPCNT+1
 .... S FDA(FILENUM,"+"_RPCNT_",?+1,",FLDNUM)=RPCIEN
 ... E  D
 .... D LOGNORPC(.XURET,IDATA,19.05)
 .. E  D
 ... I +$G(RPCIEN) S FDA(FILENUM,"+"_RPCNT_",?+1,",FLDNUM)=IDATA
 ;
 D SETOPT(.XURET,.FDA,FDAIEN)
 Q
 ;
LOGNORPC(RET,RPCNM,FILENO) ;
 ;RET( ) = SUCCESS/FAIL AT CONTEXT
 ;RET(19.05,"WARNINGS",0)=19.05 COUNT
 ;RET(19.05,"WARNINGS",1..n)=<WARNING TEXT>
 ;
 ;S RET(FILENO,"WARNINGS",0)=+$G(RET(FILENO,"WARNINGS",0))+1
 ;S RET(FILENO,"WARNINGS",$G(RET(FILENO,"WARNINGS",0)))="RPC does not exist - not filed: "_RPCNM
 N NLN S NLN=$O(RET(99999999),-1)+1
 S RET(+NLN)="WARNING"_U_"RPC does not exist - not filed: "_RPCNM
 Q
FINDRPC(RPNM) ;
 ;Find RPC by Name
 Q $$FIND1^DIC(8994,"","X",$G(RPNM),"B")
 ;
SETOPT(XURET,FDA,FDAIEN) ; find or add option entry
 ; pass by reference
 ;
 N OPTIEN,XUERR,CTXTIEN
 I +$G(FDAIEN)>0 S OPTIEN(1)=+FDAIEN
 D UPDATE^DIE("","FDA","OPTIEN","XUERR")
 I $D(XUERR("DIERR")) D
 .  S XURET(0)="-1^"_$G(XUERR("DIERR",1,"TEXT",1))_U_$P($$SITE^VASITE(),U,3)
 E  D
 .  S CTXTIEN=+$G(OPTIEN($O(OPTIEN(0))))
 .  S XURET(0)=1_U_CTXTIEN_U_$P($$SITE^VASITE(),U,3)
 Q
 ;
ADDRA2(XURET,XUARR) ; implementation of ADDRA^XUREMAP
 N APPFDA,APPIEN,STATUS,XUERR,RAIEN
 ;
 I '$D(XUARR) S XURET(0)="-1^No data passed" Q
 S STATUS=$$FDARA(.XUARR,.APPFDA)
 I +STATUS<1 S XURET(0)=STATUS Q
 ; FDA for the callback multiple
 S STATUS=$$FDACBM2(.XUARR,.APPFDA)
 I +STATUS<1 S XURET(0)=STATUS Q
 D UPDATE^DIE("E","APPFDA","APPIEN","XUERR")
 I $D(XUERR("DIERR")) D  Q
 . S XURET(0)="-1^"_$G(XUERR("DIERR",1,"TEXT",1))
 S RAIEN=+$G(APPIEN($O(APPIEN(0))))
 S XURET(0)=1_U_RAIEN
 Q
 ;
FDACBM2(XUARRM,FDA) ; Add CALLBACKTYPE to known Remote app entry
 ;
 ;  Callbacktype multiple subentries must be in order (.01, .02, .03 )
 ;  Each multiple entry can have 4 lines of data, one line each for .01,
 ;  .02, .03, and .04 fields.
 ;
 N ADDCNT,ARR,ERROR,IDATA,FILENUM,FLDNAM,FLDNUM,OPT,IENS
 S ADDCNT=0
 ;
 S ARR="XUARRM"
 F  S ARR=$Q(@ARR) Q:ARR=""  S FILENUM=+$P($P(@ARR,"^",1),";",1),FLDNUM=+$P($P(@ARR,"^",1),";",2),FLDNAM=$P(@ARR,"^",2),IDATA=$P(@ARR,"^",3) D  I $G(ERROR) Q
 . I FLDNUM=.01 S ADDCNT=ADDCNT+2,IENS="?+"_ADDCNT_"," ; increment multiple count
 . S FDA(FILENUM,IENS_"?+1,",FLDNUM)=IDATA ; URLSTRING
 I $G(ERROR) K FDA Q ERROR
 Q 1
 ;
ISFLDWP(FILENO,FIELDNO) ;
 ; function return true if input field is a word processing multiple?
 ;
 ; INPUT:
 ;   FILENO = [required] file number
 ;   FIELDNO = [required] field number in file specified by FILENO
 ;
 N RET
 D FIELD^DID(FILENO,FIELDNO,,"TYPE","RET")
 Q $G(RET("TYPE"))="WORD-PROCESSING"
CHKAEPIN(XURET,XUARR) ;
 ;CHECK THE INPUT ARRAY
 N ARR,FILENUM,FLDNUM,FLDNAM,IDATA,TIS
 S ARR="XUARR"
 S TIS=0 ;TYPE IS SET
 F  S ARR=$Q(@ARR) Q:ARR=""  S FILENUM=+$P($P(@ARR,"^",1),";",1),FLDNUM=+$P($P(@ARR,"^",1),";",2),FLDNAM=$P(@ARR,"^",2),IDATA=$P(@ARR,"^",3) D
 .  I FILENUM=19,FLDNUM=4 D
 . .  I (IDATA'="B")&(IDATA'="Broker (Client/Server)") S XURET(0)="-1^Only B-type (BROKER) options are allowed."
 . .  E  S TIS=1
 .  I FILENUM=19.05,FLDNUM=1 D
 . .  I $$FIND1^DIC(19.1,,"X",IDATA,"B")'>0 S XURET(0)="-1^Invalid security key:  Security key "_IDATA_" does not exist."
 I 'TIS S XURET(0)="-1^Only B-type (BROKER) options are allowed."
 Q
