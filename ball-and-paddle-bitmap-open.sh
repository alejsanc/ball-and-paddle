java -cp basicv2.jar com.sixtyfour.cbmnative.shell.MoSpeedCL ball-and-paddle-bitmap-open.bas -tolower=true -deadstoreopt=false -target=ball-and-paddle-bitmap-open.prg -runtimestart=16384

c1541 -format ball-and-paddle,01 d64 ball-and-paddle-bitmap-open.d64 -attach ball-and-paddle-bitmap-open.d64 -write ball-and-paddle-bitmap-open.prg ball-and-paddle -write ball-and-paddle-bitmap.koa bitmap,s

x64sc ball-and-paddle-bitmap-open.d64
