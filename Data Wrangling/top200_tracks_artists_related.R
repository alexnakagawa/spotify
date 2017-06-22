# Get track

tracks.content = sapply(1:200, function(n) {
  content(tracks[[n]])
})

tracks.content = t(tracks.content)
tracks.artists = sapply(1:200, function(n) {
  tracks.content[[n]]$artists
})

tracks.artist.names = sapply(1:200,function(n){
  tracks.artists[[n]][[1]]$name
})
tracks.artist.names = sapply(1:200,function(n){
  substr(tracks.artist.names[n],1,length(tracks.artist.names)-1)
})
tracks.song =sapply(1:200, function(n){
  tracks.content[[n]]$name
})

tracks.df = cbind(rating = 1:200, name = tracks.song)
tracks.df = tracks.df %>% as.data.frame

tracks.df$name = sapply(1:200,function(n){
  tracks.content[n,11]
})
tracks.df$pop = sapply(1:200,function(n){
  tracks.content[n,12]
})
tracks.df$album = sapply(1:200,function(n){
  tracks.content[n,1][[1]][8]
})


tracks.df$artist  = tracks.artist.names
tracks.df$track.id = sapply(1:200,function(n){
  tracks.content[n,10]
})

#--------------------------------------------------------


# Artist Analysis

# IDs for all artists in the top 200
tracks.artist.ids = lapply(1:200, function(n) {
  tracks.artists[[n]][[1]]$id
})
tracks.artist.ids = unlist(tracks.artist.ids)

tracks.df$artist.id = tracks.artist.ids

related.artists.content = sapply(1:200, function(n) {
  content(related.artists[[n]])
})

related.artists.names = sapply(1:200, function(n) {
  sapply(1:20, function(m) {
    related.artists.content[[n]][[m]]$name
  })
})
related.artists.names = t(related.artists.names)
related.artists.names = as.data.frame(related.artists.names)
related.artists.names$original = tracks.artist.names


related.artists.ids = sapply(1:200, function(n) {
  sapply(1:20, function(m) {
    related.artists.content[[n]][[m]]$id
  })
})
related.artists.ids = t(related.artists.ids)
related.artists.ids = as.data.frame(related.artists.ids)

# TODO: DO ANALYSIS ON THE RELATED ARTISTS OF EACH OF THE TOP 200 ARTISTS

#--------------------------------------------------------