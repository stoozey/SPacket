
<p align="center">
<div align="center">
  <img src="https://imgur.com/80ujevJ.png" alt="SPacket - A simple packet system for GameMaker" _target="blank" height=200/>
  </div>
  <div align="center">
   A simple packet system for GameMaker
   <p>Available for download on <a href="https://stoozey.itch.io/spacket">Itch.io</a>.</p>
   </div>
</p>

One of the biggest potential bottlenecks in a multiplayer GameMaker game is how your packets are handled.
It can be very tedious to setup, and changing anything about your own system later on may not even be feasible. SPacket is designed to be a solution to this, alongside many quality-of-life features.

### ***Why use SPacket?***

   - A minimum of only 5 bytes in packet size overhead (you could also technically make this 4 by editing the internal packet signature).
   - Easy to use and read key-value pairs, without storing the keys in the packet at all.
   - Automatic packet compression (only compresses if it would actually reduce it's size).
   - Custom exceptions are thrown for various different error scenarios, so you can make the headache of network debugging a little less painful!
   - All packets include a "version" which you can define so that you can tell if any connections are incompatible with eachother.
   - Comes with a full demo that has a dedicated server and client.
