extern crate chrono;
extern crate time;

use chrono::{DateTime, UTC};
use time::Duration;

pub fn after(datetime: DateTime<UTC>) -> DateTime<UTC> {
    let gigasecond = Duration::seconds(1_000_000_000);
    datetime + gigasecond
}
