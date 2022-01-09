# PhotosList
iOS mobile app that display list of photos queried from a public API

## Functional Requirements
- To develop iOS mobile app that displays list of photos queried from a public API, there is an ad placeholder after every 5 photos, and user can open a photo by clicking on it to be fully presented.

## Technical Requirements
- Handle API paging.
- Each view should display (Author name, Image) that are retrieved from the
API.
- Insert ad placeholder after every 5 photos.
- In the details screen, background should be the most dominant color of
the selected photo.

## Structure of the Project
- For the architecture of the app I used MVVM with RxSwift.
- This project has a layer of Network that handels the requests to Marvel API.

## Some things I'd like to add to the app

- A loading/activity indicator to notify the user when data is being read.
- Make the photos zoomable and their dominant color is used as a background color.
- Add a custom design to make the experience more enjoyable and not just the base design of iOS.
- Unit testing.


## App preview


<img src="https://user-images.githubusercontent.com/38253345/148703520-e69c5b26-e3c8-4a0d-9b4f-23abd157dd86.png" width="200"> <img src="https://user-images.githubusercontent.com/38253345/148703591-26cc9aad-c07a-4ab8-8036-d2256c9092e1.png" width="200">
<img src="https://user-images.githubusercontent.com/38253345/148703562-d360f202-2027-4254-b39a-c147d6329f7b.png" width="200">
<img src="https://user-images.githubusercontent.com/38253345/148703676-02afa9cb-0db9-4cbf-baae-c1df51d37d18.png" width="200">

