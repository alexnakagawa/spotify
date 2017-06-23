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
tracks.df$name <- unlist(tracks.df$name)

tracks.df$pop = sapply(1:200,function(n){
  tracks.content[n,12]
})
tracks.df$pop <- unlist(tracks.df$pop)

tracks.df$album = sapply(1:200,function(n){
  tracks.content[n,1][[1]][8]
})
tracks.df$album <- unlist(tracks.df$album)

tracks.df$artist  = tracks.artist.names
tracks.df$track.id = sapply(1:200,function(n){
  tracks.content[n,10]
})
tracks.df$track.id <- unlist(tracks.df$track.id)
#-----------------------------------------------------


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


temp = as.vector(related.artists.ids[[1]])
temp = as.vector(temp)
related.artists.tracks <- lapply(1:200, function(n) {
  GET(url = sprintf("https://api.spotify.com/v1/artists/%s/top-tracks?country=US",
                    temp[n]),
      config = add_headers(authorization = authorization.header))
})

related.artists.tracks.content = sapply(1:200, function(n) {
  content(related.artists.tracks[[n]])
})

related.artists.tracks.art <- sapply(1:200, function(a) {
    related.artists.tracks.content[[a]]
})

related.artists.tracks.art.songs <- lapply(1:200, function(b) {
  related.artists.tracks.art[[b]][[1]]$name
})
related.artists.tracks.art.songs <- unlist(related.artists.tracks.art.songs)

related.artists.tracks.art.artists <- lapply(1:200, function(b) {
  related.artists.tracks.art[[b]][[1]]$artists[[1]]$name
})
related.artists.tracks.art.artists <- unlist(related.artists.tracks.art.artists)

related.artists.tracks.art.ids <- lapply(1:200, function(b) {
  related.artists.tracks.art[[b]][[1]]$id
})
related.artists.tracks.art.ids <- unlist(related.artists.tracks.art.ids)

related.artists.tracks.art.pop <- lapply(1:200, function(c) {
  related.artists.tracks.art[[c]][[1]]$pop
})
related.artists.tracks.art.pop <- unlist(related.artists.tracks.art.pop)

related.artists.tracks.df <- data.frame(names = related.artists.tracks.art.songs,
                                        artists = related.artists.tracks.art.artists,
                                        ids = related.artists.tracks.art.ids,
                                        pops = related.artists.tracks.art.pop)



#--------------------------------------------------------