extern crate chrono;

use chrono::{DateTime, Duration, UTC};

pub fn after(datetime: DateTime<UTC>) -> DateTime<UTC> {
    let gigasecond = Duration::seconds(1_000_000_000);
    datetime + gigasecond
}
