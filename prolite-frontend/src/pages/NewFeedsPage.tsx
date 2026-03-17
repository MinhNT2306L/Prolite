import { useEffect, useState } from "react";

type Post = {
  id: string;
  content: string;
  author: { username: string };
  createdAt: string;
  likes: number;
};

const BRAND = "oklch(0.546 0.2153 262.8719)";

// VD: rewriteWithAI("hello world") => "Hello world."
const rewriteWithAI = (text: string) => {
  return text.charAt(0).toUpperCase() + text.slice(1).trim() + ".";
};

// ================= NEW FEEDS PAGE =================
const NewFeedsPage = () => {
  const user = { username: "lucas_dev" };

  const [posts, setPosts] = useState<Post[]>([]);
  const [content, setContent] = useState("");
  const [modalContent, setModalContent] = useState("");
  const [showComposer, setShowComposer] = useState(false);

  useEffect(() => {
    setPosts([
      {
        id: "1",
        content: "Chào mừng đến Prolite 🌌",
        author: { username: "alice" },
        createdAt: new Date().toISOString(),
        likes: 12,
      },
    ]);
  }, []);

  const createPost = (text: string) => {
    if (!text.trim()) return;

    const aiContent = rewriteWithAI(text);

    const newPost: Post = {
      id: Date.now().toString(),
      content: aiContent,
      author: { username: user.username },
      createdAt: new Date().toISOString(),
      likes: 0,
    };

    setPosts((prev) => [newPost, ...prev]);
  };

  // Quick post from the top box
  const handleQuickPost = () => {
    createPost(content);
    setContent("");
  };

  // Post from the composer modal
  const handleModalPost = () => {
    createPost(modalContent);
    setModalContent("");
    setShowComposer(false);
  };

  const deletePost = (id: string) => {
    setPosts((prev) => prev.filter((p) => p.id !== id));
  };

  return (
    <div className="min-h-screen bg-black text-white flex flex-col">
      {/* TOP BAR */}
      <header className="sticky top-0 bg-black border-b border-gray-800">
        <div
          className="text-center py-3 text-xl font-black"
          style={{ color: BRAND }}
        >
          PROLITE
        </div>
      </header>

      {/* FEED */}
      <main className="flex-1 flex justify-center">
        <div className="w-full max-w-xl px-4 py-6 space-y-6">
          {/*QUICK POST BOX */}
          <div className="border border-gray-800 rounded-2xl p-4">
            <textarea
              placeholder="Bạn đang nghĩ gì?"
              value={content}
              onChange={(e) => setContent(e.target.value)}
              rows={2}
              className="w-full bg-transparent outline-none resize-none"
            />

            <div className="flex justify-end mt-2">
              <button
                onClick={handleQuickPost}
                className="px-4 py-1.5 rounded-full bg-white text-black font-bold"
              >
                Đăng
              </button>
            </div>
          </div>

          {/* POSTS */}
          {posts.map((post) => (
            <PostCard
              key={post.id}
              post={post}
              currentUser={user.username}
              onDelete={deletePost}
            />
          ))}
        </div>
      </main>

      {/* OMPOSER MODAL */}
      {showComposer && (
        <div className="fixed inset-0 bg-black/70 flex items-center justify-center px-4">
          <div className="bg-gray-900 rounded-2xl p-5 w-full max-w-md">
            <textarea
              placeholder="Viết bài chi tiết..."
              value={modalContent}
              onChange={(e) => setModalContent(e.target.value)}
              rows={4}
              className="w-full bg-transparent outline-none resize-none"
            />

            <div className="flex justify-end gap-3 mt-4">
              <button
                onClick={() => setShowComposer(false)}
                className="text-gray-400"
              >
                Huỷ
              </button>

              <button
                onClick={handleModalPost}
                className="px-4 py-1.5 rounded-full bg-white text-black font-bold"
              >
                Đăng
              </button>
            </div>
          </div>
        </div>
      )}

      {/* BOTTOM NAV */}
      <footer className="sticky bottom-0 bg-black border-t border-gray-800">
        <div className="max-w-xl mx-auto flex justify-around py-3 text-sm">
          <button onClick={() => window.location.reload()}>Home</button>

          <button className="text-2xl" onClick={() => setShowComposer(true)}>
            ＋
          </button>

          <button onClick={() => (window.location.href = "/profile")}>
            Profile
          </button>
        </div>
      </footer>
    </div>
  );
};

export default NewFeedsPage;

// ================= POST CARD =================

interface PostCardProps {
  post: Post;
  currentUser: string;
  onDelete: (id: string) => void;
}

function PostCard({ post, currentUser, onDelete }: PostCardProps) {
  const isAuthor = post.author.username === currentUser;

  const storageKey = `like_${currentUser}_${post.id}`;

  const [liked, setLiked] = useState(
    () => localStorage.getItem(storageKey) === "true",
  );

  const [likes, setLikes] = useState(post.likes);
  const [animating, setAnimating] = useState(false);

  const toggleLike = () => {
    const newLiked = !liked;

    setLiked(newLiked);
    setLikes((prev) => (newLiked ? prev + 1 : prev - 1));
    localStorage.setItem(storageKey, newLiked.toString());

    setAnimating(true);
    setTimeout(() => setAnimating(false), 250);
  };

  return (
    <div className="border border-gray-800 rounded-2xl p-5 space-y-4">
      {/* HEADER */}
      <div className="flex justify-between items-start">
        <div className="flex gap-3">
          <div className="w-11 h-11 rounded-full bg-gray-700" />

          <div>
            <div className="font-bold">{post.author.username}</div>
            <div className="text-xs text-gray-500">
              {new Date(post.createdAt).toLocaleString()}
            </div>
          </div>
        </div>

        {/* DELETE BUTTON */}
        {isAuthor && (
          <button
            onClick={() => onDelete(post.id)}
            className="text-gray-500 hover:text-gray-300 text-lg"
          >
            X
          </button>
        )}
      </div>

      {/* CONTENT */}
      <p className="text-base leading-relaxed">{post.content}</p>

      {/* LIKE BUTTON */}
      <button
        onClick={toggleLike}
        className={`text-xl transition-transform ${
          animating ? "scale-125" : "hover:scale-110"
        }`}
      >
        {liked ? "❤️" : "🤍"} {likes}
      </button>
    </div>
  );
}
