Implementation:

BDAudioService as the singleton component to play music, that is to say, every cell contains a MusicPlayBar, and the bar has the trk, every time the bar want to play music, thay use the BDAudioService.

In detail, when the MusicPlayBar is shown, it will check the BDAudioService whether the music is playing and whether the music is the same as the bar has.
if the music is playing and is the same one as the bar has: rotate the icon, set pregress view's value.
if not music is the same one as the bar has: set the updateAction of BDAudioService
if totally not: nothing

