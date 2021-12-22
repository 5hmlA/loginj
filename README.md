# FlipOverj

### what is it

https://raw.githubusercontent.com/ZuYun/loginj/main/preview/loginj.gif



### how to use
 - pub

   ```yaml
   dependencies:
     loginj: ^0.0.2
   ```

 - example

   ```dart
   FlipOverj(
       firstFront: (context, aniValue) => firstFrontCard(context, aniValue),
       firstBack: (context, aniValue) => firstBackCard(context, aniValue),
       secondFront: (context, aniValue) => secondFrontCard(context, aniValue),
       secondBack: (context, aniValue) => secondBackCard(context, aniValue),
    )
   ```

   

   https://user-images.githubusercontent.com/9412501/145047584-5acfbd4a-a448-4d85-8878-2dd779d32f30.mp4