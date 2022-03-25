FROM denoland/deno:1.19.3

# Run time parameters with defeult. Override with -e env=val -e iso=val at run.
ENV params "-e development --iso ph"
# The port that your application listens to.
EXPOSE 8000

WORKDIR /app

# Prefer not to run as root. Commmenting out for now as it causes issue with EC2.
# USER deno

# Cache the dependencies as a layer (the following two steps are re-run only when deps.ts is modified).
# Ideally cache deps.ts will download and compile _all_ external files used in main.ts.
COPY main.ts .
COPY deps/ .
COPY api/ .
RUN deno cache --import-map=import_maps.json main.ts

# These steps will be re-run upon each file change in your working directory:
ADD . .
# Compile the main app so that it doesn't need to be compiled each startup/entry.
RUN deno cache main.ts

# CMD ["run", "-A", "--watch", "app.ts", "--iso", "$iso", "-e", $env]
CMD ["sh", "-c", "deno run -A --watch main.ts ${params}"]