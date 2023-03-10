GMRCHL7E ;AV/MKN - HL7 ENCODE/DECODE SPECIAL CHARACTERS ;06/02/2020
 ;;3.0;CONSULT/REQUEST TRACKING;**154**;JUNE 2, 2020;Build 135
 ;
 Q
 ;
DECODE(INSTR,TCH,WDAT,INSTR1) ;
 ; INSTR - Input string
 ; TCH   - translation array
 ; WDAT  - Output in a Vista compliant "Free Text" array
 ; INSTR1 - Remainder of text when last or
 ;          second to last INSTR char = "\"
 ;Development Note:
 ;\.br\ - removed and new node created
 ;\E\.br\E\ = \.br\ - (no further translation)
 ;non-printable character translation not supported
 ;Output Array nodes will contain no more than 200 characters each
 ;
 N II,CH
 S INSTR1="",WDAT=$G(WDAT)
 F II=1:1:$L(INSTR) S CH=$E(INSTR,II) D:CH="\"  S WDAT=WDAT_CH I $L(WDAT)>199 D NWNODE(.WDAT)
 . ;
 . ;  Partial TCH string, if \.br\ (CR-LF) translation allowed
 . I $L($E(INSTR,II,II+2))<3,$G(TCH("\.br\")) D  Q
 .. S INSTR1=$E(INSTR,II,II+2),II=$L(INSTR),CH=""
 . ;
 . I '$D(TCH($E(INSTR,II,II+2))) Q     ; not one we're interested in
 . I +$G(TCH($E(INSTR,II,II+2))) D  Q  ; \.br\ to <CR-LF> conversion
 .. I (II+4)>$L(INSTR) S INSTR1=$E(INSTR,II,$L(INSTR)),II=$L(INSTR),CH="" Q
 .. I +$G(TCH($E(INSTR,II,II+4))) S II=II+4,CH="" D NWNODE(.WDAT)
 . ;
 . S CH=TCH($E(INSTR,II,II+2)),II=II+2  ; std conversion
 Q WDAT   ; Return top node of WDAT - for strings less than 200 characters
 ;
NWNODE(FREERAY) ; build free text array
 N CNT
 S CNT=1+$O(FREERAY(""),-1),FREERAY(CNT)=FREERAY,FREERAY=""
 Q
 ;
ENCODE(INSTR,TCH) ;  Encode data
 N X,WCHR,OSTR
 S OSTR=""
 I $G(INSTR)]"" F X=1:1:$L(INSTR) D  S OSTR=OSTR_WCHR
 . S WCHR=$E(INSTR,X) I $D(TCH(WCHR)) S WCHR=TCH(WCHR)
 Q OSTR
 ;
