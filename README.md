# Restaurant

Implementation on Advanced CQRS course

## Requirements

ruby with bundler gem

```
gem install bundler
```

## Install dependencies

```
bundle install
```

## To run the restaurant

```
./restaurant
```

## To monitor queues, process managers and message log

```
./restaurant 2> monitoring.out
```

And in another terminal:

```
tail -f monitoring.out
```

The event log is persisted in `history.log`. Tail it to view messages as they are published:

```
tail -f history.log
```
