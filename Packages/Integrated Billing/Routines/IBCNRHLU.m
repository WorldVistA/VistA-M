IBCNRHLU ;DAOU/DMK - e-Pharmacy HL7 Utilities ;24-MAY-2004
 ;;2.0;INTEGRATED BILLING;**251**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; Description
 ;
 ; e-Pharmacy HL7 Utilities
 ;
 ; Entry points:
 ; TRAN1 - Convert HL7 special characters (specific)
 ; TRAN2 - Convert HL7 special characters (general)
 ;
 Q
 ;
TRAN1(VALUE) ; Convert HL7 special characters
 ;
 ; Specific to the following standard VistA HL7 application definition
 ; HL7 FIELD SEPARATOR = |
 ; HL7 ENCODING CHARACTERS = ^~\&
 ;
 ; Input parameter:
 ; VALUE = HL7 message field, component, or subcomponent value
 ; Invoked if value contains escape character (\)
 ;
 ; Output parameter:
 ; NEWVALUE = Converted HL7 message field, component, or subcomponent value
 ;
 N CONVERT,I,LAST,NEWVALUE,S,S3
 ;
 ; Initialize last string position involing converted special character
 S LAST=0
 ;
 ; Initialize scratch string varaible
 S S=""
 ;
 ; Initialize conversion array
 ;
 ; | = field separator
 ; Transferred as \F\ and converted to |
 S CONVERT("\F\")="|"
 ;
 ; ^ = component separator
 ; Transferred as \S\ and NOT converted to ^ (FileMan delimiter)
 ;S CONVERT("\S\")="^"
 ;
 ; ~ = repetitive separator
 ; Transferred as \R\ and converted to ~
 S CONVERT("\R\")="~"
 ;
 ; \ = escape character
 ; Transferred as \E\ and converted to \
 S CONVERT("\E\")="\"
 ;
 ; & = subcomponent separator
 ; Transferred as \T\ and converted to &
 S CONVERT("\T\")="&"
 ;
 ; Check and covert
 F I=1:1:$L(VALUE) D
 . S S=S_$E(VALUE,I)
 . I (I-3)'<LAST D
 .. ;
 .. ; Check last 3 characters and convert if necessary
 .. S S3=$E(S,$L(S)-2,$L(S))
 .. I $D(CONVERT(S3)) D
 ... S LAST=I
 ... S S=$E(S,1,$L(S)-3)_CONVERT(S3)
 S NEWVALUE=S
 Q NEWVALUE
 ;
TRAN2(VALUE,HLFS,HLECH) ; Convert HL7 special characters
 ;
 ; General to the following:
 ;
 ; HL7 Component Separator = $E(HLECH,1)
 ; HL7 Repetition Separator = $E(HLECH,2) = $E(HL("ECH"),2)
 ; HL7 Escape Character = $E(HLECH,3) = $E(HL("ECH"),3)
 ; HL7 Subcomponent = $E(HLECH,4)
 ;
 ; Invoked if value contains escape character (VALUE[$E(HL("ECH"),3)
 ;
 ; Expected variable
 ; U = "^"
 ;
 ; Input parameters:
 ; VALUE = HL7 message field, component, or subcomponent value
 ; HLFS = HL7 field separator = HL7 variable HL("FS")
 ; HLECH = HL7 encoding characters = HL7 variable HL("ECH")
 ;
 ; Output parameter:
 ; NEWVALUE = Converted HL7 message field, component, or subcomponent value
 ; Quit if any input parameters undefined
 I '$D(VALUE)!'$D(HLFS)!'$D(HLECH) Q
 ;
 N CONVERT,HLEC,I,LAST,NEWVALUE,S,S3
 ;
 ; Initialize HL7 escape character variable
 S HLEC=$E(HLECH,3)
 ;
 ; Initialize last string position involing converted special character
 S LAST=0
 ;
 ; Initialize scratch string varaible
 S S=""
 ;
 ; Initialize conversion array
 ; Do not covert to caret (^) (FileMan delimiter)
 ;
 ; Field separator
 ; Transferred as HLEC_"F"_HLEC and converted to HLFS
 S CONVERT(HLEC_"F"_HLEC)=HLFS
 ;
 ; Component separator
 ; Transferred as HLEC_"S"_HLEC and converted to $E(HLECH,1)
 I $E(HLECH,1)'=U S CONVERT(HLEC_"S"_HLEC)=$E(HLECH,1)
 ;
 ; Repetitive separator
 ; Transferred as HLEC_"R"_HLEC and converted to $E(HLECH,2)
 I $E(HLECH,2)'=U S CONVERT(HLEC_"R"_HLEC)=$E(HLECH,2)
 ;
 ; Escape character
 ; Transferred as HLEC_"E"_HLEC and converted to $E(HLECH,3)
 I $E(HLECH,3)'=U S CONVERT(HLEC_"E"_HLEC)=$E(HLECH,3)
 ;
 ; Subcomponent separator
 ; Transferred as HLEC_"T"_HLEC and converted to $E(HLECH,4)
 I $E(HLECH,4)'=U S CONVERT(HLEC_"T"_HLEC)=$E(HLECH,4)
 ;
 ; Check and covert
 F I=1:1:$L(VALUE) D
 . S S=S_$E(VALUE,I)
 . I (I-3)'<LAST D
 .. ;
 .. ; Check last 3 characters and convert if necessary
 .. S S3=$E(S,$L(S)-2,$L(S))
 .. I $D(CONVERT(S3)) D
 ... S LAST=I
 ... S S=$E(S,1,$L(S)-3)_CONVERT(S3)
 S NEWVALUE=S
 Q NEWVALUE
