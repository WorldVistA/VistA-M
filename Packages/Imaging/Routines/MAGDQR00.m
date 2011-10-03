MAGDQR00 ;WOIFO/EdM - Imaging RPCs for Query/Retrieve ; 04/05/2006 08:43
 ;;3.0;IMAGING;**51,54**;03-July-2009;;Build 1424
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ;
 ; Query/Retrieve
 ;
 ; Step 1: The application (Java system) receives a C-FIND request
 ;
 ; Step 2: The application interprets the DICOM message and
 ;         calls an RPC on traditional VistA
 ;
 ;           RPC name: MAG CFIND QUERY
 ;             input:  array of:    tag | VR | flag | value
 ;             input:  scalar:      batch-identifier, see below
 ;             input:  scalar:      max # entities in response
 ;             output: array of:    header = # entities total | # in current batch
 ;                    followed by   tag | VR | flag | value
 ;                             or   <start sequence>
 ;                             or   <end sequence>
 ;
 ;          Batch-identifier:
 ;          There are four kinds of calls:
 ;           1. initial call
 ;              value of this parameter is "0"
 ;              RPC will create result-set and start a background process to
 ;              perform the query
 ;           2. "are you ready" call
 ;              value of this parameter is "n|0"
 ;              where 'n' identifies the result-set
 ;              RPC will check if the query is ready and, when available, will
 ;              return "initial batch" of responses
 ;           3. continuation call
 ;              value of this parameter is "n|m"
 ;              where 'n' identifies the result-set
 ;              where 'm' identifies the sequence
 ;              number of the first item to be returned RPC will return
 ;              next batch of responses
 ;           4. final call
 ;              value of this parameter is "n|-1"
 ;              where 'n' identifies the result-set
 ;              RPC will not return any responses but clean-up any storage used
 ;              for result-set
 ;
 ;          Suggested values for second parameter:
 ;            0 for initial call
 ;           -1 for final call
 ;           >0 (sequence number of first entity to be returned)
 ;              for continuation call
 ;          Result-set will also have a "time stamp of last access"
 ;          so that an overall clean-up process can get rid of
 ;          obsolete result-sets.
 ;
 ; Step 3: The application interprets the results from the RPC
 ;         and will ask VistA which images belong to a
 ;         study-UID:
 ;
 ;           RPC name: MAG STUDY UID QUERY
 ;             input:  scalar       study uid
 ;             input:  scalar       flag: include routed copies in result
 ;             input:  scalar       "my location" identifier
 ;             output: array of:    header = # of entities in response
 ;                                  image# | path+file name | username | password
 ;
 ;         Do we want to return the username and password in each
 ;         result, or do we want two separate RPC calls: one to
 ;         get path+filename for each file, and one that returns
 ;         the username and password given a path?
 ;
 ; Step 4: The application will create new DICOM entities to transmit
 ;         to its client. It has the information to access the
 ;         image files that exist on VistA (either .dcm files or
 ;         .txt + .tga pairs). It needs to ask VistA for the
 ;         current and correct information to place in the headers
 ;         of the DICOM entities to be transmitted:
 ;
 ;           RPC name: MAG IMAGE CURRENT INFO
 ;             input:  scalar       image #
 ;             output: array of:    header = # of entities in response
 ;                                  tag | VS | flag | value
 ;
 ;         Do we need an additional input array to specify the
 ;         list of data-fields to be returned?
 ;
 ; Non-supported tags for Query/Retrieve
 ; 0008,1110  O  Referenced Study Sequence
 ; 0008,1150  O  >Referenced SOP Class UID
 ; 0008,1155  O  >Referenced SOP Instance UID
 ; 0008,1120  O  Referenced Patient Sequence
 ; 0008,1150  O  >Referenced SOP Class UID
 ; 0008,1155  O  >Referenced SOP Instance UID
 ; 0010,1020  O  Patient's Size   [field not populated]
 ; 0010,1030  O  Patient's Weight [field not populated]
 ; 0020,1070  O  Other Study Numbers
 ; 0020,1200  O  Number of Patient Related Studies
 ; 0020,1202  O  Number of Patient Related Series
 ; 0020,1204  O  Number of Patient Related Instances
 ;
 ; Supported tags
 ; 0008,0020  R  Study Date
 ; 0008,0030  R  Study Time
 ; 0008,0050  R  Accession Number
 ; 0010,0010  R  Patient's Name
 ; 0010,0020  R  Patient ID
 ; 0020,0010  R  Study ID
 ; 0020,000D  U  Study Instance UID
 ; 0008,0018  U  Image Instance UID
 ; 0020,000E  U  Series Instance UID
 ;
 ; 0008,0061  O  Modalities in Study
 ; 0008,0090  O  Referring Physician's Name
 ; 0008,1030  O  Study Description
 ; 0008,1032  O  Procedure Code Sequence
 ; 0008,0100  O  >Code Value
 ; 0008,0102  O  >Coding Scheme Designator
 ; 0008,0103  O  >Coding Scheme Version
 ; 0008,0104  O  >Code Meaning
 ; 0008,1060  O  Name of Physician(s) Reading Study
 ; 0010,0030  O  Patient's Birth Date
 ; 0010,0032  O  Patient's Birth Time [probably always blank]
 ; 0010,0040  O  Patient's Sex
 ; 0010,1000  O  Other Patient IDs
 ; 0010,1001  O  Other Patient Names
 ; 0010,1010  O  Patient's Age
 ; 0010,2160  O  Ethnic Group
 ; 0010,2180  O  Occupation
 ; 0010,21B0  O  Additional Patient History
 ; 0020,1206  O  Number of Study Related Series
 ; 0020,1208  O  Number of Study Related Instances
 ; 4008,010C  O  Interpretation Author
 ;
 ; Problem cases left over:
 ; 0008,0062  O  SOP Classes in Study [supported?]
 ; 0008,1080  O  Admitting Diagnoses Description
 ; 0010,4000  O  Patient Comments
 ;
