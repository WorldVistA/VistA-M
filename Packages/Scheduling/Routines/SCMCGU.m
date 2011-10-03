SCMCGU ;ALB/JLU;General PCMM utilities;7/1/99 ; 3/29/00 12:34pm
 ;;5.3;Scheduling;**195,177,212**;AUG 13, 1993
 ;
NEWPERSN(IEN,ARY) ;This function takes an internal value/DUZ of the
 ;person you wish info on and performs a silent FM call to retrieve
 ;the data.  DBIA #10060
 ;
 ;INPUTS
 ;  IEN - the internal entry number of the user you want in 
 ;        VA(200. (REQUIRED)
 ;  ARY - the closed array reference the data is to be returned in.
 ;        This must be a clean array.  This API will not issue any 
 ;        kills with this structure.(OPTIONAL)  
 ;        If no array is entered ^TMP("PCMM_PERSON",$J,IEN) will be used.
 ;
 ;OUTPUTS
 ;   ARY(IEN)=Piece Structure below
 ;   1 - User Name (EXTERNAL)
 ;   2 - Office Phone number
 ;   3 - Room
 ;   4 - Service/Section (EXTERNAL)
 ;   5 - Voice Pager number
 ;   6 - Social Security number
 ;
 ;If successful 1 is return as the results of the function.
 ;If not successfull 0^reason is returned.
 ;
 N STOP
 S STOP=0
 D PARCHK G:STOP MNQ
 D GETDATA
MNQ Q $S(STOP=0:1,1:0_U_$P(STOP,U,2))
 ;
PARCHK ;Checks the parameters that are passed in.
 ;
 I '+$G(IEN) S STOP="1^Bad pointer value to file 200"
 I $G(ARY)']"" S ARY="^TMP(""PCMM_PERSON"",$J)"
 Q
 ;
GETDATA ;Make the FM calls and formats the return array.
 ;
 N BLDERR
 K ^TMP("SCMC_BLD_PERSON",$J)
 D GETS^DIQ(200,IEN,".01;.132;.137;.141;29;9","EI","^TMP(""SCMC_BLD_PERSON"","_$J_")","BLDERR")
 ;only reporting the first one
 I $D(BLDERR) S STOP=1_U_BLDERR("DIERR",1,"TEXT",1) Q
 S $P(@ARY@(IEN),U,1)=^TMP("SCMC_BLD_PERSON",$J,200,IEN_",",.01,"E")
 S $P(@ARY@(IEN),U,2)=^TMP("SCMC_BLD_PERSON",$J,200,IEN_",",.132,"E")
 S $P(@ARY@(IEN),U,3)=^TMP("SCMC_BLD_PERSON",$J,200,IEN_",",.141,"E")
 S $P(@ARY@(IEN),U,4)=^TMP("SCMC_BLD_PERSON",$J,200,IEN_",",29,"E")
 S $P(@ARY@(IEN),U,5)=^TMP("SCMC_BLD_PERSON",$J,200,IEN_",",.137,"E")
 S $P(@ARY@(IEN),U,6)=^TMP("SCMC_BLD_PERSON",$J,200,IEN_",",9,"E")
 K ^TMP("SCMC_BLD_PERSON",$J)
 Q
 ;
PDAT(SCPATCH,SCERROR) ;
 ; alb/rpm Patch 212
 ; This function is used to retrieve the PATCH install date when
 ; passed the PATCH name.  The PATCH install date is found in the
 ; subfile #9.4901 field #.02.
 ;
 ; DBIA:#10048 indicates that Package(#9.4) file is open for read
 ; only with FM.
 ;
 ;   Input:
 ;        SCPATCH - Patch designation (i.e. SD*5.3*177)
 ;        SCERROR (optional) - Variable stores user named variable
 ;                             to return error text.  Passing ""
 ;                             is treated the same as no parameter.
 ;
 ;   Output:
 ;        Function value - Date patch installed on success, otherwise 0 
 ;                         on failure.
 ;        SCERROR - Variable stores error text explaining function
 ;                  failure.  Only output if user passes second
 ;                  parameter to function and an error occurs.
 ;
 ; Validate input
 I $L(SCPATCH,"*")'=3 D  Q 0
 . S:$G(SCERROR)]"" @SCERROR="Invalid input parameter"
 ; Verify patch is loaded
 I '$$PATCH^XPDUTL(SCPATCH) D  Q 0
 . S:$G(SCERROR)]"" @SCERROR="Patch "_SCPATCH_" not loaded"
 ; Initialize locals
 NEW SCDATE,SCFILE,SCI,SCERR,SCIEN,SCPAT
 ; Search for Patch designation in #9.4 and subfiles (#9.49, #9.4901)
 S SCIEN=""
 F SCI=1:1:3 D  Q:$D(SCERR)!'SCIEN(SCI)
 . S SCFILE=$S(SCI=1:9.4,SCI=2:9.49,1:9.4901)
 . S SCPAT=$P(SCPATCH,"*",SCI)
 . S SCIEN(SCI)=$$FIND1^DIC(SCFILE,SCIEN,"MX",SCPAT,"","","SCERR")
 . ; Check for alternate form of patch name (i.e. "176 SEQ #158") 
 . I SCI=3,'SCIEN(SCI) S SCPAT=SCPAT_" SEQ" D
 . . S SCIEN(SCI)=$$FIND1^DIC(SCFILE,SCIEN,"M",SCPAT,"","","SCERR")
 . Q:$D(SCERR)!'SCIEN(SCI)
 . S SCIEN=$S(SCI<3:",",1:"")_SCIEN(SCI)_$S(SCI=1:",",1:"")_SCIEN
 ; Check for search errors
 I 'SCIEN(SCI) S:$G(SCERROR)]"" @SCERROR="Search failed" Q 0
 I $D(SCERR) S:$G(SCERROR)]"" @SCERROR=$G(SCERR("DIERR",1,"TEXT",1)) Q 0
 ;
 ; Retrieve date
 S SCDATE=$$GET1^DIQ(SCFILE,SCIEN,.02,"I","","SCERR")
 I $D(SCERR) S:$G(SCERROR)]"" @SCERROR=$G(SCERR("DIERR",1,"TEXT",1)) Q 0
 ;
 D CLEAN^DILF
 Q SCDATE
