# ====================================================

# An attempt to predict with a certain probability that a song will reach the Global Top 200

# ====================================================

# Libraries
library(dplyr)
library(ggplot2)
library(party)

# A little more Data Wrangling...


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